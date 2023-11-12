import 'dart:async';

import 'package:flutter/material.dart';

enum DirectionMarguee {
  oneDirection,
  twoDirection,
}

class Marquee extends StatefulWidget {
  final Widget child;
  final TextDirection textDirection;
  final Axis direction;
  final Duration delay, animationDuration, backDuration, pauseDuration;
  final DirectionMarguee directionMarguee;
  final Cubic forwardAnimation;
  final Cubic backwardAnimation;
  final bool autoRepeat;

  const Marquee({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.textDirection = TextDirection.ltr,
    this.animationDuration = const Duration(milliseconds: 5000),
    this.backDuration = const Duration(milliseconds: 5000),
    this.pauseDuration = const Duration(milliseconds: 2000),
    this.delay = const Duration(milliseconds: 50),
    this.directionMarguee = DirectionMarguee.twoDirection,
    this.forwardAnimation = Curves.easeIn,
    this.backwardAnimation = Curves.easeOut,
    this.autoRepeat = true,
  }) : super(key: key);

  @override
  State<Marquee> createState() => _MarqueeState();
}

class _MarqueeState extends State<Marquee> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  // 使用 AnimationController 控制 _scrollController 的 offset，以便接收点击事件
  late final AnimationController _aniController;
  Animation<Offset>? _aniOffset;

  // _scrollController.animateTo 过程中不接收点击事件
  _scroll(bool repeated) async {
    do {
      if (_scrollController.hasClients) {
        await Future.delayed(widget.pauseDuration);
        if (_scrollController.hasClients) {
          await _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: widget.animationDuration,
              curve: widget.forwardAnimation);
        }
        await Future.delayed(widget.pauseDuration);
        if (_scrollController.hasClients) {
          switch (widget.directionMarguee) {
            case DirectionMarguee.oneDirection:
              _scrollController.jumpTo(
                0.0,
              );
              break;
            case DirectionMarguee.twoDirection:
              await _scrollController.animateTo(0.0,
                  duration: widget.backDuration,
                  curve: widget.backwardAnimation);
              break;
          }
        }
        repeated = widget.autoRepeat;
      } else {
        await Future.delayed(widget.pauseDuration);
      }
    } while (repeated);
  }

  _updateCurve(Curve curve) {
    CurvedAnimation curveAni = CurvedAnimation(
      parent: _aniController,
      curve: curve,
    );

    _aniOffset = Tween(
      begin: Offset.zero,
      end: Offset(
        _scrollController.position.maxScrollExtent,
        0,
      ),
    ).animate(curveAni);
  }

  void _aniListener() {
    _scrollController.jumpTo(_aniOffset?.value.dx ?? 0);
  }

  void _aniStatusListener(status) async {
    if (!widget.autoRepeat) return;
    if (!_scrollController.hasClients) return;
    await Future.delayed(widget.pauseDuration);
    if (!mounted) return;

    if (status == AnimationStatus.completed) {
      switch (widget.directionMarguee) {
        case DirectionMarguee.oneDirection:
          _aniController.reset();

          _updateCurve(widget.forwardAnimation);
          _aniController.forward();
          break;
        case DirectionMarguee.twoDirection:
          _updateCurve(widget.backwardAnimation);
          _aniController.reverse();
          break;
      }
    } else if (status == AnimationStatus.dismissed) {
      if (widget.directionMarguee == DirectionMarguee.twoDirection) {
        _updateCurve(widget.forwardAnimation);
        _aniController.forward();
      }
    }
  }

  @override
  void initState() {
    _aniController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: widget.backDuration,
    )
      ..addListener(_aniListener)
      ..addStatusListener(_aniStatusListener);

    Future.delayed(widget.delay).then((value) {
      if (!mounted) return;
      if (!_scrollController.hasClients) return;

      _updateCurve(widget.forwardAnimation);
      _aniController.forward();
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _aniController.removeListener(_aniListener);
    _aniController.removeStatusListener(_aniStatusListener);
    _aniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: widget.textDirection,
      child: SingleChildScrollView(
        child: widget.child,
        scrollDirection: widget.direction,
        controller: _scrollController,
      ),
    );
  }
}
