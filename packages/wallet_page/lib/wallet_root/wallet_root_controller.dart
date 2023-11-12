import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:base/app_config.dart';
import 'package:base/app_event_bus.dart';
import 'package:base/app_routes.dart';
import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/utils/log_utils.dart';
import 'package:base/commons/widgets/ol_loading_widget.dart';
import 'package:base/commons/widgets/ol_normal_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:services/api/common_apis.dart';
import 'package:services/api/wallet_apis.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/event/balance_refresh.dart';
import 'package:services/models/res/login/image_code_model.dart';
import 'package:services/models/res/wallet/user_wallet_model.dart';
import 'package:services/provider/common_provider.dart';
import 'package:wallet_page/recharge_confirm_dialog/recharge_confirm_dialog.dart';

class WalletRootController extends GetXBaseController {
  Rx<UserWalletModel?> wallet = UserWalletModel().obs;
  RxList ways = [].obs;
  var seleWays = 0.obs;
  var seleTongDao = 0.obs;
  var seleMoeny = (-1).obs;

  bool showLeading = false;

  ///0 1余额 2金币  默认余额
  var accountType = 0.obs;

  var activityType = 100.obs;

  StreamSubscription? _balanceSubscription;


  late final RefreshController refreshController;

  @override
  void onInit() {
    refreshController = RefreshController();
    accountType.value = 0;
    if (AppConfig.isVideo) {
      accountType.value = 2;
    }

    activityType.value = 100;
    try {
      Map<String, dynamic>? arguments = Get.arguments;
      String? taccountType = arguments?["accountType"];
      if (taccountType?.isNotEmpty ?? false) {
        accountType.value = int.parse(taccountType ?? "0");
      }
      String? activity = arguments?["activity"];
      if (activity?.isNotEmpty ?? false) {
        activityType.value = int.parse(activity ?? "0");
      }
    } catch (e) {
      print(e);
    }
    getUserWallet();
    getPayData();
    // 监听刷新余额消息
    _balanceSubscription = eventBus.on<BalanceEvent>().listen((event) {
      Future.delayed(const Duration(seconds: 2), () {
        getUserWallet();
      });
    });
    super.onInit();
  }

  getUserWallet() async {
    try {
      wallet.value = await CommonProvider.getUserWallet();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }

  }
  ///刷新事件
  onRefresh() async {
    getUserWallet();
    getPayData();
  }

  // getPayData() async {
  //   try {
  //     ways.value = await WalletApis.of.call().getPayData();
  //     // OLUserManager.shared.save(res);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  getPayData() async {
    try {
      ways.value = await WalletApis.of.call().getPayDataV2(true);
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }

  }
  
  

  recharge(int code) async {
    // 判断是否是游客账号
    var mobilePhone = UserManagerCache.shared
        .getUserDetail()
        ?.mobilePhone ?? "";
    if (mobilePhone.isEmpty) {
      //游客账号
      //手机号为空,引导用户绑定手机号，并设置账户密码
      Get.dialog(NormalDialogWidgetAlert(
          controller: this,
          cancelTitle: "继续充值",
          content: "您当前为游客账号，请绑定手机，以防账号丢失",
          callBack: (type) async {
            if (1 == type) {
              Get.toNamed(
                AppRoutes.register,
                arguments: {
                  "type": 6,
                },
              );
            } else {
              getCode(code);
            }
          }));
    } else {
      getCode(code);
    }
  }


  getCode(int type) async {
    try {
      OLEasyLoading.showLoading('');
      ImageCodeModel? imagecode = await CommonProvider.randCode(type);
      OLEasyLoading.dismiss();
      if (imagecode == null) {
        OLEasyLoading.showToast(basePageString("验证码获取失败,请重试"));
        return;
      }
      Get.dialog(
        RechargeConfirmDialog(
          imagecode: imagecode,
          backCode: ways[seleWays.value]
              .payChannelVOList?[seleTongDao.value]
              .channelCode ??
              "",
          payWayId: ways[seleWays.value]
              .payChannelVOList?[seleTongDao.value]
              .payWayId ??
              '',
          price: ways[seleWays.value]
              .payChannelVOList?[seleTongDao.value]
              .moneys()[seleMoeny.value] ??
              "",
          accountType: accountType.value,
          activityType: activityType.value,
          walletRootController: this,
        ),
        barrierDismissible: false,
      );
    } catch (e) {
      Log.d('imagecode3: $e');
      OLEasyLoading.dismiss();
      OLEasyLoading.showToast(basePageString("图片验证码获取失败,请重试"));
    }
  }


  rechargeComplete() async {
    Get.dialog(NormalDialogWidgetAlert(
        controller: this,
        cancelTitle: "未完成",
        sureTitle: "已完成",
        content: "充值是否完成？",
        callBack: (type) async {
          if (1 == type) {
            getUserWallet();
            getPayData();
          }
        }
    ));
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }
}
