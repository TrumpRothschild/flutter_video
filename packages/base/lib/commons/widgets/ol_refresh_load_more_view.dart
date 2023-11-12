import 'package:flutter/material.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';

import 'ol_blank_view.dart';

/// 获取到需要创建的视图
typedef BuildWidgetCallback = Widget Function();
typedef RefreshCallback = Future<bool> Function();
typedef LoadMoreCallback = Future<bool> Function();

/// 通用下拉刷新,上拉加载更多组件
class OlRefreshLoadMoreView extends StatefulWidget {
  const OlRefreshLoadMoreView(
      {Key? key,
      required this.refreshCallback,
      required this.loadMoreCallback,
      required this.buildWidgetCallback})
      : super(key: key);

  final RefreshCallback refreshCallback;
  final LoadMoreCallback loadMoreCallback;
  final BuildWidgetCallback buildWidgetCallback;

  @override
  State<OlRefreshLoadMoreView> createState() => _OlRefreshLoadMoreViewState();
}

class _OlRefreshLoadMoreViewState extends State<OlRefreshLoadMoreView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  bool _hasMoreData = false;

  void refresh() async {
    _hasMoreData = await widget.refreshCallback();
    _updateRefresh();
  }

  void loadMore() async {
    _hasMoreData = await widget.loadMoreCallback();
    _updateRefresh();
  }

  void _updateRefresh() {
    if (_hasMoreData) {
      _refreshController.loadComplete();
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: _hasMoreData,
      enablePullDown: true,
      header: const WaterDropHeader(),
      onRefresh: () async {
        refresh();
      },
      onLoading: () async {
        loadMore();
      },
      child: widget.buildWidgetCallback(),
    );
  }
}
