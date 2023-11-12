import 'package:base/bases/get_base_controller.dart';
import 'package:base/commons/widgets/ol_keep_alive_widget.dart';
import 'package:base_page/common/notice_dialog_widget.dart';
import 'package:base_page/common/update_page.dart';
import 'package:base_page/constant/notice_type.dart';
import 'package:base_page/utils/app_version_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_page/agora/rtm_utils.dart';
import 'package:services/common/cache/user_manager_cache.dart';
import 'package:services/models/res/live/agora_token_bean.dart';
import 'package:services/provider/home_provider.dart';
import 'package:services/models/res/home/home_tab_bean.dart';
import 'package:services/models/res/notice/notice_bean.dart';
import 'package:services/provider/common_provider.dart';

import '../view/home_follow_page.dart';
import '../view/home_nearby_page.dart';
import '../view/home_other_page.dart';
import '../view/home_recommend_page.dart';
import '../view/home_video_page.dart';

/// 首页controller
class HomeController extends GetXBaseController
    with StateMixin<List<HomeTabBean>?> {
  static HomeController of() => HomeController();

  /// 当前tab
  RxString? curTabCode = 'recommend'.obs;

  @override
  void onInit() {
    _getColumn();
    super.onInit();
  }

  @override
  void onReady() {
    /// 登录IM
    _getRtmToken();
    // 首页公告弹框
    _getAdvNotice();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

    /// 登出IM
    RTMUtils.logout();
  }

  ///获取首页tab数据
  _getColumn() async {
    HomeProvider.getColumn().then(
        (value) => {change(value, status: RxStatus.success())},
        onError: (err) =>
            {change(null, status: RxStatus.error(err.toString()))});
  }

  /// 获取tab对应的页面
  List<Widget> getTabBarViews(List<HomeTabBean>? tabs) {
    List<Widget> list = [];
    tabs?.forEach((element) {
      if (element.columnCode == "focus") {
        // 关注
        list.add(const OlKeepAliveWidget(child: HomeFollowPage()));
      } else if (element.columnCode == "recommend") {
        //推荐
        list.add(const OlKeepAliveWidget(child: HomeRecommendPage()));
      } else if (element.columnCode == "nearby") {
        //附近
        list.add(const OlKeepAliveWidget(child: HomeNearbyPage()));
      } else if (element.columnCode == "star") {
        //星秀
        list.add(const OlKeepAliveWidget(child: HomeVideoPage()));
      } else {
        list.add(OlKeepAliveWidget(
            child: HomeOtherPage(
          columnCode: element.columnCode,
        )));
      }
    });
    return list;
  }

  /// 全局公告,一条数据
  _getAdvNotice() {
    CommonProvider.getAdvNotice(NoticeType.homeNotice).then((value) {
      _showNoticeDialog(value);
    }).whenComplete(() {
      // 延迟0.5秒检测升级
      Future.delayed(const Duration(milliseconds: 500), () {
        _checkNewVersion();
      });
    });
  }

  /// 版本更新
  _checkNewVersion() async {
    CommonProvider.queryAppVersion("bball").then((value) async {
      if (value == null) {
        return;
      }
      int result = await AppVersionUtil.isUpdate(value.showVersion);
      if (1 == result || 2 == result) {
        Get.dialog(
            UpdatePage(
              controller: this,
              bean: value,
              isForce: 2 == result,
            ),
            // 设置背景透明是为了解决两个弹框背景重叠黑色加深问题
            barrierColor: Colors.transparent,
            barrierDismissible: 1 == result);
      }
    });
  }

  /// 展示公告dialog
  _showNoticeDialog(NoticeBean? bean) {
    String noticeContent = bean?.noticeContent ?? "";
    if (noticeContent.isEmpty) {
      return;
    }
    // Get.dialog(NoticeDialogWidget(controller: this, bean: bean));
  }

  /// 获取IM的token
  _getRtmToken() {
    CommonProvider.getRtmToken().then((value) {
      AgoraTokenBean? tokenBean = value;
      int uid = UserManagerCache.shared.info?.id ?? 0;

      /// 登录IM
      if (!GetUtils.isNull(tokenBean) && uid > 0) {
        RTMUtils.login(tokenBean?.token, uid.toString());
      }
    });
  }
}
