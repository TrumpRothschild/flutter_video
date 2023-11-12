import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/caches/ol_cache_manager.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/commons/widgets/ol_normal_dialog_widget.dart';
import 'package:base_page/common/update_page.dart';
import 'package:base_page/gesture_pwd/update_ges_pwd/update_ges_pwd_page.dart';
import 'package:base_page/utils/app_version_util.dart';
import 'package:get/get.dart';
import 'package:mine_page/set_up/change_password/change_password_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/common/cache/gesture_pwd_cache.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/app_version_baen.dart';
import 'package:services/models/res/base_response.dart';
import 'package:services/provider/user_provider.dart';

enum SetupCellType {
  arrow,
  subtitle,
  onOff,
  grident,
}

class SetupCellModel {
  String title;
  String subtitle;
  bool isOn;
  final SetupCellType? cellType;
  final int index;

  SetupCellModel({
    this.title = '',
    this.subtitle = '',
    this.isOn = false,
    this.cellType,
    required this.index,
  });
}

class SetUpController extends GetXBaseController {
  bool isLocked = false;

  List<SetupCellModel> get cellModels => _cellModels;
  final _cellModels = [
    SetupCellModel(
      title: '账户安全中心',
      cellType: SetupCellType.arrow,
      index: 0,
    ),
    SetupCellModel(
      title: '账户密码',
      cellType: SetupCellType.arrow,
      index: 1,
    ),
    SetupCellModel(
      title: '支付密码',
      cellType: SetupCellType.arrow,
      index: 2,
    ),
    SetupCellModel(
      title: '地区',
      cellType: SetupCellType.subtitle,
      subtitle: '中国',
      index: 3,
    ),
    SetupCellModel(
      title: '语言',
      cellType: SetupCellType.subtitle,
      subtitle: '简体中文',
      index: 4,
    ),
    SetupCellModel(
      title: 'APP应用锁',
      cellType: SetupCellType.onOff,
      index: 5,
    ),
    SetupCellModel(
      title: '检查更新',
      cellType: SetupCellType.grident,
      subtitle: '最新',
      index: 6,
    ),
  ].obs;

  String _proName = '';

  void onCellTap(SetupCellModel cell) {
    switch (cell.index) {
      case 0:
        _toAccountSafety();
        break;
      case 1:
        _toAccountPwdPage();
        break;
      case 2:
        _toPayPwdPage();
        break;
      case 5:
        _toGesturePwdUpdate();
        break;
      case 6:
        _checkNewVersion(true);
        break;
    }
  }

  void _toAccountSafety() {
    Get.toNamed(AppRoutes.accountSafety);
  }

  // 账户密码
  Future<void> _toAccountPwdPage() async {
    var mobilePhone =
        UserManagerCache.shared.getUserDetail()?.mobilePhone ?? "";
    if (mobilePhone.isEmpty == true) {
      //手机号为空,引导用户绑定手机号，并设置账户密码
      Get.dialog(NormalDialogWidgetAlert(
          controller: this,
          content: "您当前为游客账号，请先绑定手机号码哦，以防账号丢失",
          callBack: (type) async {
            if (1 == type) {
              Get.toNamed(
                AppRoutes.register,
                arguments: {
                  "type": 6,
                },
              );
            }
          }));
    } else {
      //已绑定手机号，查询是否已设置账户密码，已设则进入修改密码页面，未设置进入设置密码页面
      _getUserPasswordStatus(1);
    }
  }

  // 支付密码
  Future<void> _toPayPwdPage() async {
    var mobilePhone =
        UserManagerCache.shared.getUserDetail()?.mobilePhone ?? "";
    if (mobilePhone.isEmpty == true) {
      //手机号为空,引导用户绑定手机号
      Get.dialog(NormalDialogWidgetAlert(
          controller: this,
          content: "您当前为游客账号，请先绑定手机号码哦，以防账号丢失",
          callBack: (type) async {
            if (1 == type) {
              Get.toNamed(AppRoutes.phoneBind);
            }
          }));
    } else {
      //已绑定手机号，查询是否已设置支付密码，已设则进入修改支付密码页面，未设置进入设置密码页面
      _getUserPasswordStatus(2);
    }
  }

  void _toGesturePwdUpdate() async {
    final versionCell = _cellModels.lastWhere((element) => element.index == 5);
    versionCell.isOn = !versionCell.isOn;
    if (versionCell.isOn) {
      final gesPwd = await GesturePwdCache.instance.getCachedGesPwd();
      if (gesPwd.isEmpty) {
        final isSucc = await Get.toNamed(
              AppRoutes.gesturePwdUpdate,
              arguments: UpdateGesPwdStep.setNewPwd,
            ) as bool? ??
            false;
        if (!isSucc) {
          versionCell.isOn = false;
        }
      }
    } else {
      GesturePwdCache.instance.updateCachedGesPwd('');
    }
    _cellModels.refresh();
  }

  ///reqType	1：登录密码 2：支付密码 3: 是否绑定了手机号
  _getUserPasswordStatus(int reqType) async {
    UserProvider.getUserPasswordStatus(reqType).then((value) {
      if (value == false) {
        // 修改密码
        Get.toNamed(
          AppRoutes.changePassword,
          arguments: reqType == 1
              ? ChangePwdPageType.updateAccountPwd
              : ChangePwdPageType.updatePayPwd,
        );
      } else {
        // 设置密码
        Get.toNamed(
          AppRoutes.changePassword,
          arguments: reqType == 1
              ? ChangePwdPageType.setAccountPwd
              : ChangePwdPageType.setPayPwd,
        );
      }
    });
  }

  @override
  void onInit() {
    GesturePwdCache.instance.getCachedGesPwd().then((gesPwd) {
      final versionCell =
          _cellModels.lastWhere((element) => element.index == 5);
      versionCell.isOn = gesPwd.isNotEmpty;
      _cellModels.refresh();
    });
    super.onInit();
  }

  @override
  void onReady() {
    PackageInfo.fromPlatform().then((info) {
      final versionCell =
          _cellModels.lastWhere((element) => element.index == 6);
      _proName = info.appName;
      _checkNewVersion(false);
      versionCell.title = versionCell.title + ' ' + info.version;
      _cellModels.refresh();
    });
    super.onReady();
  }

  /// 版本更新
  _checkNewVersion(bool click) async {
    if (_proName.isEmpty) return;
    try {
      OLEasyLoading.showLoading('');
      BaseResponse res = await CommonApis.of().queryAppVersion(_proName);
      if (GetUtils.isNull(res.data) == true) {
        OLEasyLoading.dismiss();
        return;
      }
      final appVersion = AppVersionBean.fromJson(res.data);
      if (appVersion.showVersion.isNotEmpty) {
        final versionCell =
            _cellModels.lastWhere((element) => element.index == 6);
        versionCell.subtitle = '发现新版本 ' + appVersion.showVersion;
        _cellModels.refresh();
      }
      OLEasyLoading.dismiss();
      if (click) {
        int result = await AppVersionUtil.isUpdate(appVersion.showVersion,
            isClick: true);
        if (1 == result || 2 == result) {
          //barrierDismissible 设置为false，点击空白处弹窗不关闭
          Get.dialog(
              UpdatePage(
                controller: this,
                bean: appVersion,
                isForce: 2 == result,
              ),
              barrierDismissible: 1 == result);
        }
      }
    } catch (e) {
      OLEasyLoading.dismiss();
    }
  }

  /// 退出登录
  logout() {
    UserProvider.userLogout().then((value) {
      Log.d("登出成功！");
      UserManagerCache.shared.clearCache();
    }).whenComplete(() {
      //跳转登录页面
      Get.offAllNamed(AppRoutes.loginPage, arguments: 1);
    });
  }
}
