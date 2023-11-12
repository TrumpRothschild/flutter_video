import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @date 2023/02/21  14:41
/// @author a-bert
/// @des Getx 在Tabview中使用AutomaticKeepAliveClientMixin保持页面状态组件

class OlKeepAliveWidget extends StatefulWidget {
  final Widget child;

  const OlKeepAliveWidget({Key? key, required this.child}) : super(key: key);

  @override
  _OlKeepAliveWidgetState createState() => _OlKeepAliveWidgetState();
}

class _OlKeepAliveWidgetState extends State<OlKeepAliveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
