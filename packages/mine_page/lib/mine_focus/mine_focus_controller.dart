import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:get/get.dart';
import 'package:mine_page/mine_focus/widgets/unfocus_dialog.dart';
import 'package:mine_page/models/page_model.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/models/res/user/user_detail_model.dart';

class MineFocusController extends GetXBaseController {
  late final RefreshController refreshController;

  List<UserDetailModel> get focusUsers => _focusUsers;
  final _focusUsers = <UserDetailModel>[].obs;

  int _pageNum = 1;
  int _total = 0;

  void onTapItem(UserDetailModel user) {}

  void onUnfocusUser(UserDetailModel user) {
    Get.dialog(
      UnfocusDialog(
        customTheme: currentCustomThemeData(),
        onUnfocus: () async {
          Get.back();
          bool isSucc = await _onUnfocus(user);
          if (isSucc) {
            _focusUsers.remove(user);
            _focusUsers.refresh();
          }
        },
      ),
      barrierDismissible: false,
    );
  }

  void onRefresh() async {
    _pageNum = 1;
    _getFocusList();
  }

  void onLoading() async {}

  @override
  void onInit() {
    refreshController = RefreshController();
    super.onInit();
  }

  @override
  void onReady() {
    refreshController.requestRefresh();
    super.onReady();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  _getFocusList() async {
    UserDetailModel? userDetail = UserManagerCache.shared.getUserDetail();

    if (userDetail?.id == null) {
      return;
    }
    try {
      BaseResponse res = await CommonApis.of().getFocusList(
        pageNum: _pageNum,
        userId: userDetail?.id ?? 0,
        pageSize: 15,
      );
      if (GetUtils.isNull(res.data) == true) {
        if (_pageNum == 1) {
          refreshController.refreshFailed();
        } else {
          refreshController.loadFailed();
        }
        return;
      }
      final dataJson = res.data as Map<String, dynamic>;

      if (dataJson['list'] != null && dataJson['list'] is List) {
        final list = dataJson['list'] as List;
        final listModel = list
            .map(
              (e) => UserDetailModel.fromJson(e),
            )
            .toList();
        dataJson['list'] = listModel;
      }
      PageModel<UserDetailModel> pageModel =
          PageModel<UserDetailModel>.fromJson(dataJson);
      _total = pageModel.total;
      if (_pageNum == 1) {
        _focusUsers.clear();
        refreshController.refreshCompleted();
        refreshController.resetNoData();
      } else {
        refreshController.loadComplete();
      }
      _focusUsers.addAll(pageModel.list);
      if (focusUsers.length >= _total) {
        refreshController.loadNoData();
      }
    } catch (e) {
      if (_pageNum == 1) {
        refreshController.refreshFailed();
      } else {
        refreshController.loadFailed();
      }
    }
  }

  Future<bool> _onUnfocus(UserDetailModel user) async {
    if (user.userId == null) return false;
    try {
      OLEasyLoading.showLoading('');
      BaseResponse response = await CommonApis.of().unfocusUser({
        "focusUserId": user.userId,
        "isInRoom": false,
      });
      if (GetUtils.isNull(response) == true) {
        OLEasyLoading.dismiss();
        return false;
      }
      OLEasyLoading.dismiss();
      return response.code == 200;
    } catch (e) {
      OLEasyLoading.dismiss();
      return false;
    }
  }
}
