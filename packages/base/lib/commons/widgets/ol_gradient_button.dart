import 'package:flutter/material.dart';

/// 渐变按钮
class OlGradientButton extends StatelessWidget {
  const OlGradientButton({
    Key? key,
    this.colors,
    this.width,
    this.height,
    this.borderRadius,
    required this.tapCallback,
    required this.child,
    this.disable = false,
  }) : super(key: key);

  final List<Color>? colors; // 渐变色数组
  final double? width; // 按钮 宽
  final double? height; // 按钮 高
  final BorderRadius? borderRadius; // 按钮 圆角

  final GestureTapCallback tapCallback;
  final bool disable; // 禁用

  final Widget child; // 子组件

  @override
  Widget build(BuildContext context) {
    List<Color> _colors = [];
    if (disable) {
      //确保colors数组不空
      _colors = [Colors.grey.withAlpha(100), Colors.grey.withAlpha(100)];
    } else {
      //确保colors数组不空
      _colors = colors ?? [const Color(0xff6129FF), const Color(0xffD96CFF)];
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(colors: _colors),
      ),
      child: Material(
        type: MaterialType.transparency, // 透明材质 用于绘制墨水飞溅和高光
        child: InkWell(
          onTap: disable ? null : tapCallback,
          splashColor: _colors.last,
          borderRadius: borderRadius,
          enableFeedback: !disable,
          // 是否给予操作反馈
          highlightColor: Colors.transparent,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: width, height: height),
            child: Center(
              child: child
            ),
          ),
        ),
      ),
    );
  }
}
