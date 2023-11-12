import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/themes/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/pduration.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_home_page/edit_information/models/info_cell_model.dart';
import 'package:mine_page/mine_home_page/edit_information/widgets/cancel_confirm_sheet.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/user_detail_model.dart';
import 'package:services/models/res/user/user_occupation_model.dart';
import 'package:services/provider/user_provider.dart';

import 'widgets/photo_choice_sheet.dart';

class EditInformationController extends GetXBaseController {
  final UserDetailModel? _user = UserManagerCache.shared.getUserDetail();
  List<InfoCellModel> cells = [];

  final List<UserOccupationModel> _genders = [
    UserOccupationModel(occupationCode: '1', occupationName: '男'),
    UserOccupationModel(occupationCode: '2', occupationName: '女'),
    UserOccupationModel(occupationCode: '0', occupationName: '保密'),
  ];

  final List<UserOccupationModel> _emotions = [
    UserOccupationModel(occupationCode: '2', occupationName: '恋爱'),
    UserOccupationModel(occupationCode: '1', occupationName: '单身'),
    UserOccupationModel(occupationCode: '3', occupationName: '已婚'),
    UserOccupationModel(occupationCode: '0', occupationName: '保密'),
  ];

  List<String> get _jobs =>
      _userOccupations.map((e) => e.occupationName).toList();

  final List<UserOccupationModel> _userOccupations = [];

  void onTap(InfoCellModel model) async {
    CustomTheme customTheme = currentCustomThemeData();
    switch (model.cellType) {
      case InfoCellType.avatar:
        final newAvatarUrl = await Get.bottomSheet(
              PhotoChoiceSheet(
                customTheme: currentCustomThemeData(),
              ),
            ) as String? ??
            '';
        if (newAvatarUrl.isNotEmpty) {
          model.avatar = newAvatarUrl;
          await _updateUserAvatar();
          update();
        }
        break;
      case InfoCellType.valueOnly:
        break;
      case InfoCellType.valuArrow:
        List<String> items = [];
        switch (model.cellActionType) {
          case InfoCellActionType.avatar:
            break;
          case InfoCellActionType.nickname:
            final newNickname = await Get.toNamed(
                  AppRoutes.nickName,
                  arguments: model.value,
                ) as String? ??
                '';
            if (newNickname.isNotEmpty && newNickname != model.value) {
              model.value = newNickname;
              update();
            }
            break;
          case InfoCellActionType.none:
            break;
          case InfoCellActionType.gender:
            items = _genders.map((e) => e.occupationName).toList();
            break;
          case InfoCellActionType.sign:
            final newSign = await Get.toNamed(
                  AppRoutes.sign,
                  arguments: model.value,
                ) as String? ??
                '';
            if (newSign.isNotEmpty && newSign != model.value) {
              model.value = newSign;
              update();
            }
            break;
          case InfoCellActionType.birthday:
            await showDatePicker(
              (newDate) async {
                final formattedDate =
                    '${newDate.year}-${newDate.month.toString().padLeft(2, '0')}-${newDate.day.toString().padLeft(2, '0')}';
                // 处理选择后的日期
                if (formattedDate != model.value) {
                  model.value = formattedDate;
                  final succ = await _updateUserInfo();
                  if (succ) {
                    update();
                  }
                }
              },
            );
            break;
          case InfoCellActionType.emotion:
            items = _emotions.map((e) => e.occupationName.toString()).toList();
            break;
          case InfoCellActionType.hometowm:
            final address = model.value.split('-');
            String initProvince = '四川省', initCity = '成都市';
            if (address.length == 1) {
              initProvince = address.first;
            } else if (address.length == 2) {
              initProvince = address.first;
              initCity = address.last;
            }

            Pickers.showAddressPicker(
              Get.context!,
              initProvince: initProvince,
              initCity: initCity,
              // initTown: initTown,
              onConfirm: (p, c, t) async {
                model.value = p;
                if (c != '全部') {
                  model.value += '-' + c;
                }
                final succ = await _updateUserInfo();
                if (succ) {
                  update();
                }
              },
            );
            break;
          case InfoCellActionType.job:
            if (_userOccupations.isEmpty) {
              await _getUserOccupationList();
            }
            items = _jobs;
            break;
        }
        if (items.isNotEmpty) {
          Get.bottomSheet(
            CancelConfirmSheet(
              customTheme: customTheme,
              selectedItem: model.value,
              items: items,
              onConfirm: (String value) async {
                Get.back();
                if (model.value != value) {
                  model.value = value;
                  final succ = await _updateUserInfo();
                  if (succ) {
                    update();
                  }
                }
              },
            ),
          );
        }
        break;
    }
  }

  Future<void> showDatePicker(ValueChanged<DateTime> callback) async {
    Pickers.showDatePicker(
      Get.context!,
      mode: DateMode.YMD,
      suffix: Suffix.normal(),
      // selectDate: PDuration(month: 2),
      // minDate: PDuration(year: 2020, month: 2, day: 10),
      maxDate: PDuration(
        year: DateTime.now().year,
        month: DateTime.now().month,
        day: DateTime.now().day,
      ),
      // selectDate: PDuration(
      //   year: selectedDate?.year ?? 1999,
      //   month: selectedDate?.month ?? 1,
      //   day: selectedDate?.day ?? 1,
      // ),
      // minDate: PDuration(hour: 12, minute: 38, second: 3),
      // maxDate: PDuration(hour: 12, minute: 40, second: 36),
      onConfirm: (p) {
        // selectData[model] = '${p.year}-${p.month}';
        // 处理选择后的日期
        DateTime newDate = DateTime(p.year ?? 1999, p.month ?? 1,p.day??1);
        callback(newDate);
      },
      // onChanged: (p) => print(p),
    );
    // DateTime? selectedDate;
    // await Get.bottomSheet(
    //   Container(
    //     color: currentCustomThemeData().colors0xFFFFFF,
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             CupertinoButton(
    //               child: const Text('取消'),
    //               onPressed: Get.back,
    //             ),
    //             CupertinoButton(
    //               child: const Text('确定'),
    //               onPressed: () => Get.back(result: selectedDate),
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 200.0,
    //           child: CupertinoDatePicker(
    //             mode: CupertinoDatePickerMode.date,
    //             dateOrder: DatePickerDateOrder.ymd,
    //             onDateTimeChanged: (DateTime dateTime) {
    //               selectedDate = dateTime;
    //             },
    //             initialDateTime: DateTime.now(),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    // return selectedDate;
  }

  _getUserOccupationList() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().getUserOccupationList();
      OLEasyLoading.dismiss();
      if (GetUtils.isNull(res.data)) return;

      final dataArr = res.data as List;
      _userOccupations.clear();
      _userOccupations.addAll(dataArr
          .map(
            (e) => UserOccupationModel.fromJson(e),
          )
          .toList());
      cells.last.value = _userOccupations
          .firstWhere(
            (element) => element.occupationCode == _user?.occupationCode,
            orElse: () => UserOccupationModel(),
          )
          .occupationName;
      update();
    } catch (e) {
      OLEasyLoading.dismiss();
    }
  }

  Future<bool> _updateUserInfo() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().updateUserInfo(
        sex: int.parse(_genders
            .firstWhere(
              (element) => element.occupationName == cells[3].value,
              orElse: () => UserOccupationModel(occupationCode: '-1'),
            )
            .occupationCode),
        birthday: "${cells[5].value}T00:00:00+0800",
        maritalStatus: int.parse(_emotions
            .firstWhere(
              (element) => element.occupationName == cells[6].value,
              orElse: () => UserOccupationModel(occupationCode: '-1'),
            )
            .occupationCode),
        hometown: cells[7].value,
        occupationCode: _userOccupations
            .firstWhere(
              (element) => element.occupationName == cells[8].value,
              orElse: () => UserOccupationModel(occupationCode: '-1'),
            )
            .occupationCode,
      );
      UserProvider.getUserInfo()
          .then((value) => UserManagerCache.shared.setUserDetail(value));
      OLEasyLoading.dismiss();
      return res.data == true;
    } catch (e) {
      Log.d(e.toString());
      OLEasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> _updateUserAvatar() async {
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res =
          await CommonApis.of().updateUserAvatar(cells[0].avatar);
      UserProvider.getUserInfo()
          .then((value) => UserManagerCache.shared.setUserDetail(value));
      OLEasyLoading.dismiss();
      return res.data == true;
    } catch (e) {
      Log.d(e.toString());
      OLEasyLoading.dismiss();
      return false;
    }
  }

  @override
  void onInit() {
    cells = [
      InfoCellModel(
        title: '头像',
        cellType: InfoCellType.avatar,
        avatar: _user?.avatar ?? '',
        cellActionType: InfoCellActionType.avatar,
      ),
      InfoCellModel(
        title: '昵称',
        value: _user?.nickName ?? '',
        cellActionType: InfoCellActionType.nickname,
      ),
      InfoCellModel(
        title: '账号',
        value: _user?.accno ?? '',
        cellType: InfoCellType.valueOnly,
        cellActionType: InfoCellActionType.none,
      ),
      InfoCellModel(
        title: '性别',
        value: _user?.gender ?? '',
        cellActionType: InfoCellActionType.gender,
      ),
      InfoCellModel(
        title: '签名',
        value: _user?.personalSignature ?? 'TA好像忘记签名了',
        cellActionType: InfoCellActionType.sign,
      ),
      InfoCellModel(
        title: '生日',
        value: (_user?.birthday ?? '').split("T")[0].replaceAll("T", "replace"),
        cellActionType: InfoCellActionType.birthday,
      ),
      InfoCellModel(
        title: '情感',
        value: _user?.emotion ?? '',
        cellActionType: InfoCellActionType.emotion,
      ),
      InfoCellModel(
        title: '家乡',
        value: _user?.hometown ?? '',
        cellActionType: InfoCellActionType.hometowm,
      ),
      InfoCellModel(
        title: '职业',
        value: _user?.occupationName ?? '',
        cellActionType: InfoCellActionType.job,
      ),
    ];
    super.onInit();
  }

  @override
  void onReady() {
    _getUserOccupationList();
    super.onReady();
  }
}
