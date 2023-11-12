import 'package:flutter/material.dart';

class LiveGameIndicator extends Decoration {
  final double? height;
  final Gradient? gradient;

  const LiveGameIndicator({
    this.height,
    this.gradient,
  });

  @override
  _UnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(
      this,
      onChanged,
      indicatorHeight: height,
      indicatorGradient: gradient,
    );
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(
    this.decoration,
    VoidCallback? onChanged, {
    this.indicatorHeight,
    this.indicatorGradient,
    this.index,
    this.tabLength,
  }) : super(onChanged);

  final LiveGameIndicator decoration;
  final double? indicatorHeight;
  final Gradient? indicatorGradient;
  final int? index;
  final int? tabLength;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    var width = configuration.size?.width ?? 0;
    var height = configuration.size?.height ?? 0;

    Rect rect = Rect.fromPoints(
      offset + Offset(0, height.toDouble()),
      offset + Offset(width, 0),
    );
    Gradient gradient = indicatorGradient ??
        LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: const [Color(0xff6129FF), Color(0xffD96CFF)],
          stops: const [0.03, 0.95],
        );
    RRect rRect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(5),
    );

    canvas.drawRRect(
      rRect,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = gradient.createShader(rect),
    );
  }
}
