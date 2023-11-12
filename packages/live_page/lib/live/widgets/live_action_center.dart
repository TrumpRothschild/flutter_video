import 'package:base/commons/utils/app_date_utils.dart';
import 'package:base/res/app_dimens.dart';
import 'package:base/res/font_dimens.dart';
import 'package:flutter/material.dart';
import 'package:services/image/ol_image.dart';
import 'package:services/models/res/live/live_action_bean.dart';
import 'package:services/models/res/live/live_action_list_bean.dart';
import 'package:get/get.dart';
import '../live_page.dart';

/// 直播间活动中心
class LiveActionCenter extends StatelessWidget {
  final LiveController _controller = Get.find<LiveController>();
  final LiveActionListBean? actionListBean;

  LiveActionCenter(this.actionListBean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: AppDimens.w_16,
                ),
                onTap: Get.back),
            title: Text(
              "活动中心",
              style: TextStyle(
                  color: _controller.currentCustomThemeData().colors0x333333,
                  fontSize: FontDimens.fontSp18),
            ),
            bottom: _tabWidget(),
          ),
          body: Container(
            padding: const EdgeInsets.all(AppDimens.h_10),
            color: _controller.currentCustomThemeData().colors0x9F44FF,
            child: TabBarView(
              children: [
                actionListWidget(actionListBean?.gameList ?? []),
                actionListWidget(actionListBean?.liveList ?? [])
              ],
            ),
          ),
        ));
  }

  PreferredSize _tabWidget() {
    var _tabs = [
      const Tab(
        height: AppDimens.h_34,
        text: "活动中心",
      ),
      const Tab(
        height: AppDimens.h_34,
        text: "直播活动",
      )
    ];
    return PreferredSize(
      preferredSize: const Size.fromHeight(AppDimens.h_16),
      child: ColoredBox(
        color: _controller.currentCustomThemeData().colors0x9F44FF,
        child: TabBar(
          labelStyle: const TextStyle(
              fontSize: FontDimens.fontSp16, fontWeight: FontWeight.w400),
          labelColor: Colors.white,
          unselectedLabelColor:
              _controller.currentCustomThemeData().colors0xFFFFFF_60,
          unselectedLabelStyle: const TextStyle(
              fontSize: FontDimens.fontSp16, fontWeight: FontWeight.w500),
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _tabs,
          onTap: (index) {},
        ),
      ),
    );
  }

  /// 活动列表
  Widget actionListWidget(List<LiveActionBean> beans) {
    return ListView.builder(
        itemCount: beans.length,
        itemBuilder: (BuildContext context, int index) {
          LiveActionBean bean = beans[index];
          return _actionItem(bean);
        });
  }

  /// 活动item
  Widget _actionItem(LiveActionBean bean) {
    return Container(
        padding: const EdgeInsets.all(AppDimens.w_8),
        margin: const EdgeInsets.only(bottom: AppDimens.w_10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimens.w_10)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: OLImage(
                imageUrl: bean.imgUrl ?? "",
                width: double.infinity,
                height: AppDimens.h_126,
              ),
            ),
            const SizedBox(height: AppDimens.h_8),
            _nameOrDate(bean)
          ],
        ));
  }

  /// 活动名称和日期
  Widget _nameOrDate(LiveActionBean bean) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(bean.activityName ?? "",
            style: TextStyle(
                color: _controller.currentCustomThemeData().colors0x6300C7,
                fontSize: FontDimens.fontSp16,
                fontWeight: FontWeight.w500)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.w_8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.w_5),
            gradient: const LinearGradient(
                colors: [Color(0xff6129FF), Color(0xffD96CFF)],
                stops: [0.0353, 0.9571]),
          ),
          child: Text(
            bean.permanent == true
                ? "截止至：${AppDateUtils.stringToYMDString(bean.endDate ?? "")}"
                : "活动时间：永久有效",
            style: const TextStyle(
                color: Colors.white,
                fontSize: FontDimens.fontSp12,
                fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
