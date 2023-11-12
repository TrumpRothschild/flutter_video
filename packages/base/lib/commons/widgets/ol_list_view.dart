import 'package:flutter/material.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'dart:typed_data';

/// 获取到需要创建的视图
typedef BuildWidgetCallback = Widget Function(Widget parentView, int index);
typedef LoadMoreCallback = Future<bool> Function(Widget parentView);

/// 异步执行方法
// typedef AsyncVoidCallback = Future<void> Function();
/// 使用方法
/// refreshCallback 刷新的回调处理
/// loadMoreCallback 加载更多的处理
/// dataList 列表需要的参数
///
/// 基础列表 包含刷新    空白页处理
class OLListView extends StatelessWidget {
  OLListView({
    Key? key,
    required this.dataList,
    this.refreshCallback,
    this.loadMoreCallback,
    this.buildWidgetCallback,
  }) : super(key: key);

  final List<dynamic> dataList;
  final LoadMoreCallback? refreshCallback;
  final LoadMoreCallback? loadMoreCallback;
  final BuildWidgetCallback? buildWidgetCallback;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Widget buildEmpty() {
    return OLBlankView();
  }

  Widget buildChild(int index) {
    if (buildWidgetCallback != null) {
      return buildWidgetCallback!(this, index);
    }
    return Text("没有实现 buildWidgetCallback $index");
  }

  void refresh() async {
    bool hasMoreData = true;
    if (refreshCallback != null) {
      hasMoreData = await refreshCallback!(this);
    }
    updateRefresh(hasMoreData);
  }

  void loadMore() async {
    bool hasMoreData = true;
    if (loadMoreCallback != null) {
      hasMoreData = await loadMoreCallback!(this);
    }
    updateRefresh(hasMoreData);
  }

  void updateRefresh(bool hasMoreData) {
    if (dataList.isEmpty) {
      _refreshController.loadNoData();
    } else {
      if (hasMoreData) {
        _refreshController.loadComplete();
      } else {
        _refreshController.refreshCompleted();
      }
    }

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: dataList.isNotEmpty,
      enablePullDown: true,
      header: const WaterDropHeader(),
      onRefresh: () async {
        refresh();
      },
      onLoading: () async {
        loadMore();
      },
      child: dataList.isEmpty
          ? buildEmpty()
          : ListView.builder(
              itemBuilder: (_, index) => buildChild(index),
              itemCount: dataList.length,
              itemExtent: 100.0,
            ),
    );
  }
}
