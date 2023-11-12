
import 'package:flutter/material.dart';
import 'package:base/commons/widgets/ol_blank_view.dart';
import 'package:flutter/material.dart';
import 'package:ol_pull_refresh_view/pull_to_refresh.dart';
import 'ol_list_footer_widget.dart';

/// 获取到需要创建的视图
typedef BuildWidgetCallback = Widget Function(Widget parentView, int index);
typedef LoadMoreCallback = Future<bool> Function(Widget parentView);

/// 异步执行方法
// typedef AsyncVoidCallback = Future<void> Function();

// 本次修改仅仅是将 OlGridView 修改为 StatefulWidget：因为使用 StatelessWidget 时在
// 将 footerMode 设置成 LoadStatus.noMore 之后，调用 loadComplete() 和 resetNoData()，
// 都不能将 footerMode 恢复为 LoadStatus.idle

/// 基础列表 包含刷新    空白页处理
class OlGridView extends StatefulWidget {
  const OlGridView(
      {Key? key,
      this.padding,
      required this.dataList,
      this.refreshCallback,
      this.loadMoreCallback,
      this.buildWidgetCallback,
      this.footer,
      required this.gridDelegate})
      : super(key: key);

  final EdgeInsetsGeometry? padding;
  final SliverGridDelegate gridDelegate;
  final List<dynamic> dataList;
  final LoadMoreCallback? refreshCallback;
  final LoadMoreCallback? loadMoreCallback;
  final BuildWidgetCallback? buildWidgetCallback;
  final Widget? footer;

  @override
  State<OlGridView> createState() => _OlGridViewState();
}

class _OlGridViewState extends State<OlGridView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Widget buildEmpty() {
    return OLBlankView();
  }

  Widget buildChild(int index) {
    if (widget.buildWidgetCallback != null) {
      return widget.buildWidgetCallback!(widget, index);
    }
    return Text("没有实现 buildWidgetCallback $index");
  }

  void refresh() async {
    bool hasMoreData = true;
    if (widget.refreshCallback != null) {
      hasMoreData = await widget.refreshCallback!(widget);
    }
    updateRefresh(hasMoreData);
  }

  void loadMore() async {
    bool hasMoreData = true;
    if (widget.loadMoreCallback != null) {
      hasMoreData = await widget.loadMoreCallback!(widget);
    }
    updateMoreRefresh(hasMoreData);
  }

  void updateRefresh(bool hasMoreData) {
    if (widget.dataList.isEmpty) {
      _refreshController.loadNoData();
    } else {
      if (!hasMoreData) {
        _refreshController.refreshCompleted();
      }
    }
    _refreshController.loadComplete();
  }

  void updateMoreRefresh(bool hasMoreData) {
    if (widget.dataList.isEmpty) {
      _refreshController.loadNoData();
    } else {
      if (!hasMoreData) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: widget.dataList.isNotEmpty,
      enablePullDown: true,
      header: const WaterDropHeader(),
      footer: widget.footer != null ? widget.footer : ListFooterWidget(),
      onRefresh: () async {
        refresh();
      },
      onLoading: () async {
        loadMore();
      },
      child: widget.dataList.isEmpty
          ? buildEmpty()
          : GridView.builder(
              padding: widget.padding,
              gridDelegate: widget.gridDelegate,
              itemBuilder: (_, index) => buildChild(index),
              itemCount: widget.dataList.length,
            ),
    );
  }
}
