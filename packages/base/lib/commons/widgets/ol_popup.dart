import 'package:flutter/material.dart';

/// 弹框
class OlPopup<T> extends PopupRoute<T> {
  final Duration _duration = const Duration(milliseconds: 300);
  final Widget child;

  OlPopup(this.child);

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    throw Material(color: Colors.transparent, child: child);
  }

  @override
  Duration get transitionDuration => _duration;
}
