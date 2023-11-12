import 'package:flutter/material.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';

/// 获取到需要创建的视图
typedef BuildWidgetCallback = Widget Function();

/// 定义刷新
typedef RefreshCallback = Future<bool> Function();

/// 通用下拉刷新组件

class OlRefreshView extends StatelessWidget {
  OlRefreshView({Key? key,
    required this.refreshCallback,
    required this.buildWidgetCallback})
      : super(key: key);

  final RefreshCallback refreshCallback;
  final BuildWidgetCallback buildWidgetCallback;

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void refresh() async {
    await refreshCallback();
    _refreshController.refreshCompleted();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: const WaterDropHeader(),
      onRefresh: () async {
        refresh();
      },
      child: buildWidgetCallback(),
    );
  }
}
