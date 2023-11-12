import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 上下滚动的消息轮播
class MarqueeWidget extends StatefulWidget {
  /// 子视图数量
  final int count;

  ///子视图构建器
  final IndexedWidgetBuilder itemBuilder;

  ///轮播的时间间隔
  final int loopSeconds;
  final int animationsSeconds;

  final bool useBigBlankSpace;

  /// 滚动方向
  final Axis scrollDirection;

  const MarqueeWidget({
    Key? key,
    required this.count,
    required this.itemBuilder,
    this.loopSeconds = 3000,
    this.animationsSeconds = 10000,
    this.scrollDirection = Axis.vertical,
    this.useBigBlankSpace = false,
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late PageController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    _timer =
        Timer.periodic(Duration(milliseconds: widget.loopSeconds), (timer) {
      if (_controller.page != null) {
        // 如果当前位于最后一页，则直接跳转到第一页，两者内容相同，跳转时视觉上无感知
        if (_controller.page!.round() >= widget.count) {
          _controller.jumpToPage(0);
        }
        _controller.nextPage(
            duration: Duration(milliseconds: widget.animationsSeconds),
            curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useBigBlankSpace) {
      return SingleChildScrollView(
        scrollDirection: widget.scrollDirection,
        controller: _controller,
        child: Row(
          children: List.generate(widget.count + 1, (index) {
            if (index == widget.count) {
              return widget.itemBuilder(context, 0);
            }
            return widget.itemBuilder(context, index);
          }),
        ),
      );
    }
    return PageView.builder(
      scrollDirection: widget.scrollDirection,
      controller: _controller,
      itemBuilder: (buildContext, index) {
        if (index < widget.count) {
          return widget.itemBuilder(buildContext, index);
        } else {
          return widget.itemBuilder(buildContext, 0);
        }
      },
      itemCount: widget.count + 1,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _timer.cancel();
  }
}
