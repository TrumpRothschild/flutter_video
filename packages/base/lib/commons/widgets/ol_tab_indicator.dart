import 'package:flutter/material.dart';

/// tabBar指示器
class OlTabBarIndicator extends Decoration {
  final double? height;
  final Gradient? gradient;

  const OlTabBarIndicator({
    this.height,
    this.gradient,
  });

  @override
  _UnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _UnderlinePainter(this, onChanged,
        indicatorHeight: height,
        indicatorGradient: gradient);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(
    this.decoration,
    VoidCallback? onChanged, {
    this.indicatorHeight,
    this.indicatorGradient,
  }) : super(onChanged);

  final OlTabBarIndicator decoration;
  final double? indicatorHeight;
  final Gradient? indicatorGradient;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    var width = configuration.size?.width ?? 0;
    var height = configuration.size?.height ?? 0;
    final halfWidth = width/2 ;
    final halfHeight = indicatorHeight??height;
    final centerX = halfWidth + offset.dx;
    final bottom = height;

    Rect rect = Rect.fromLTRB(centerX-halfWidth/2,bottom-halfHeight,centerX+halfWidth/2,bottom);

  /*  Rect rect = Rect.fromPoints(
      offset + Offset(0, height.toDouble()),
      offset + Offset(width, height - (indicatorHeight ?? height)),
    );*/
    Gradient gradient = indicatorGradient ??
        const LinearGradient(
          colors: [Color(0xff6129FF), Color(0xffD96CFF)],
          stops: [0.03, 0.95],
        );
    RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(4));

    canvas.drawRRect(
      rRect,
      Paint()
        ..style = PaintingStyle.fill
        ..shader = gradient.createShader(rect),
    );
  }
}
