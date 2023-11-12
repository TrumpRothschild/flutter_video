
import 'package:flutter/material.dart';

// 自定义形状的指示器
class OLRectangleIndicator extends Decoration {

  // 构造器
  const OLRectangleIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
    this.radius = 4.0,
    this.padding = const EdgeInsets.all(2.0),
    this.rectangleColor = Colors.redAccent,
    this.shadowColor,
  });

  // 设置边框样式
  final BorderSide borderSide;
  final EdgeInsetsGeometry insets;

  // 设置圆角
  final double radius;
  @override

  // 设置偏移量
  final EdgeInsets padding;

  // 自定义形状的颜色
  final Color rectangleColor;

  // 渐变颜色
  final Color? shadowColor;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(this, onChanged);
  }

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    return Rect.fromLTWH(
      indicator.left + padding.left,
      padding.top,
      indicator.width - padding.left - padding.right,
      indicator.height - padding.top - padding.bottom,
    );
  }

  @override
  Path getClipPath(Rect rect, TextDirection textDirection) {
    return Path()..addRect(_indicatorRectFor(rect, textDirection));
  }
}

class _CirclePainter extends BoxPainter {
  _CirclePainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  final OLRectangleIndicator decoration;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection textDirection = configuration.textDirection!;
    // 计算 indicator 的 rect
    final Rect indicator = decoration._indicatorRectFor(rect, textDirection).deflate(decoration.borderSide.width / 2.0);
    // 定义绘制的样式
    final RRect rrect = RRect.fromRectAndRadius(indicator, Radius.circular(decoration.radius));
    final Paint paint = decoration.borderSide.toPaint()
      ..style = PaintingStyle.fill
      ..color = decoration.rectangleColor;
    final Path path = Path()..addRRect(rrect.shift(const Offset(1, 1)));
    // 绘制阴影
    if (decoration.shadowColor != null) {
      canvas.drawShadow(path, decoration.shadowColor!, 4, false);
    }
    // 绘制圆角矩形
    canvas.drawRRect(rrect, paint);
  }
}
