import 'dart:math' as math;
import 'dart:math';

import 'package:base/assets.gen.dart';
import 'package:flutter/material.dart';

import 'circular_menu_item.dart';

class CircularMenu extends StatefulWidget {
  final List<CircularMenuItem> items;
  final AlignmentGeometry alignment;
  final double radius;
  final Widget? backgroundWidget;
  final VoidCallback? toggleButtonOnPressed;
  final double toggleButtonSize;

  const CircularMenu({
    Key? key,
    required this.items,
    this.alignment = Alignment.bottomCenter,
    this.radius = 60,
    this.backgroundWidget,
    this.toggleButtonOnPressed,
    this.toggleButtonSize = 40,
  }) : super(key: key);

  @override
  CircularMenuState createState() => CircularMenuState();
}

class CircularMenuState extends State<CircularMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late double _initialAngle;
  double? _completeAngle;

  double? _screenWidth, _screenHeight;
  double? _screenWidthMid, _screenHeightMid;
  double? _left, _top;

  late AlignmentGeometry _alignment;

  late int _itemsCount;

  @override
  void initState() {
    _alignment = widget.alignment;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.fastOutSlowIn,
      ),
    );
    super.initState();
    changeStateInit();
  }

  void _configure() {
    switch (_alignment.toString()) {
      case 'Alignment.bottomCenter':
        _completeAngle = 1 * math.pi;
        _initialAngle = 1 * math.pi;
        break;
      case 'Alignment.topCenter':
        _completeAngle = 1 * math.pi;
        _initialAngle = 0 * math.pi;
        break;
      case 'Alignment.centerLeft':
        _completeAngle = 1 * math.pi;
        _initialAngle = 1.5 * math.pi;
        break;
      case 'Alignment.centerRight':
        _completeAngle = 1 * math.pi;
        _initialAngle = 0.5 * math.pi;
        break;
      case 'Alignment.center':
        _completeAngle = 2 * math.pi;
        _initialAngle = 0 * math.pi;
        break;
      case 'Alignment.bottomRight':
        _completeAngle = 0.5 * math.pi;
        _initialAngle = 1 * math.pi;
        break;
      case 'Alignment.bottomLeft':
        _completeAngle = 0.5 * math.pi;
        _initialAngle = 1.5 * math.pi;
        break;
      case 'Alignment.topLeft':
        _completeAngle = 0.5 * math.pi;
        _initialAngle = 0 * math.pi;
        break;
      case 'Alignment.topRight':
        _completeAngle = 0.5 * math.pi;
        _initialAngle = 0.5 * math.pi;
        break;
      default:
        _completeAngle = 1 * math.pi;
        _initialAngle = 1 * math.pi;
        break;
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    _configure();
    super.didUpdateWidget(oldWidget);
  }

  List<Widget> _buildMenuItems() {
    List<Widget> items = [];
    widget.items.asMap().forEach((index, item) {
      items.add(
        Container(
          margin: const EdgeInsets.all(40),
          alignment: _alignment,
          child: Transform.translate(
            offset: Offset.fromDirection(
                _completeAngle == (2 * math.pi)
                    ? (_initialAngle +
                        (_completeAngle! / (_itemsCount)) * index)
                    : (_initialAngle +
                        (_completeAngle! / (_itemsCount - 1)) * index),
                _animation.value * widget.radius),
            child: Transform.scale(
              scale: _animation.value,
              child: Transform.rotate(
                angle: _animation.value * (math.pi * 2),
                child: item,
              ),
            ),
          ),
        ),
      );
    });
    return items;
  }

  Widget _buildMenuButton(BuildContext context) {
    final Size sizeMo = MediaQuery.of(context).size;
    return Positioned(
      left: _left ?? sizeMo.width / 2 - 20,
      top: _top ?? sizeMo.height - 80,
      child: Draggable(
        onDragEnd: _handleDragEnded,
        child: CircularMenuItem(
          onTap: () {
            _animationController.status == AnimationStatus.dismissed
                ? (_animationController).forward()
                : (_animationController).reverse();
            if (widget.toggleButtonOnPressed != null) {
              widget.toggleButtonOnPressed!();
            }
          },
          menuWidget: SizedBox(
            width: widget.toggleButtonSize,
            height: widget.toggleButtonSize,
            child: Image.asset(
              Assets.gamePage.icFButton.path,
            ),
          ),
        ),
        feedback: CircularMenuItem(
          onTap: () {
            _animationController.status == AnimationStatus.dismissed
                ? (_animationController).forward()
                : (_animationController).reverse();
            if (widget.toggleButtonOnPressed != null) {
              widget.toggleButtonOnPressed!();
            }
          },
          menuWidget: SizedBox(
            width: widget.toggleButtonSize,
            height: widget.toggleButtonSize,
            child: Image.asset(
              Assets.gamePage.icFButton.path,
            ),
          ),
        ),
        childWhenDragging: const SizedBox(
          width: 0.0,
          height: 0.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.backgroundWidget ?? Container(),
        ..._buildMenuItems(),
        _buildMenuButton(context),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleDragEnded(DraggableDetails draggableDetails) {
    _calculatePosition(draggableDetails.offset);
  }

  void _calculatePosition(Offset? targetOffset) {
    if (_screenWidthMid == null || _screenHeightMid == null) {
      Size screenSize = MediaQuery.of(context).size;
      _screenWidth = screenSize.width;
      _screenHeight = screenSize.height;
      _screenWidthMid = (_screenWidth! / 2);
      _screenHeightMid = _screenHeight! / 2;
    }
    print(_getAnchor(targetOffset!));
    switch (_getAnchor(targetOffset)) {
      case Anchor.leftTop:
        _left = 40;
        _top = 40;
        _alignment = Alignment.topLeft;
        break;
      case Anchor.leftCenter:
        _left = 40;
        _top = _screenHeight! / 2 - 20;
        _alignment = Alignment.centerLeft;
        break;
      case Anchor.leftBottom:
        _left = 40;
        _top = _screenHeight! - 80;
        _alignment = Alignment.bottomLeft;
        break;
      case Anchor.bottomCenter:
        _left = _screenWidthMid! - 20;
        _top = _screenHeight! - 80;
        _alignment = Alignment.bottomCenter;
        break;
      case Anchor.rightBottom:
        _left = _screenWidth! - 80;
        _top = _screenHeight! - 80;
        _alignment = Alignment.bottomRight;
        break;
      case Anchor.rightCenter:
        _left = _screenWidth! - 80;
        _top = _screenHeight! / 2 - 20;
        _alignment = Alignment.centerRight;
        break;
      case Anchor.rightTop:
        _left = _screenWidth! - 80;
        _top = 40;
        _alignment = Alignment.topRight;
        break;
      case Anchor.topCenter:
        _left = _screenWidthMid! - 20;
        _top = 40;
        _alignment = Alignment.topCenter;
        break;
    }
    changeStateInit();
    setState(() {});
  }

  Anchor _getAnchor(Offset position) {
    //LEFT
    if (position.dx < (_screenWidthMid! / 2) &&
        position.dy < (_screenHeightMid! / 2)) {
      return Anchor.leftTop;
    } else if (position.dx < (_screenWidthMid! / 2) &&
        position.dy < (_screenHeightMid! / 2)) {
      return Anchor.leftCenter;
    } else if (position.dx < (_screenWidthMid! / 2) &&
        position.dy < (_screenHeightMid! + _screenHeightMid! / 2)) {
      return Anchor.leftCenter;
    } else if (position.dx < (_screenWidthMid! / 2) &&
        position.dy < (_screenHeightMid! + _screenHeightMid!)) {
      return Anchor.leftBottom;
    }

    // CENTER LEFT
    else if (position.dx < (_screenWidthMid!) &&
        position.dy < (_screenHeightMid! / 2)) {
      return Anchor.topCenter;
    } else if (position.dx < (_screenWidthMid!) &&
        position.dy < (_screenHeightMid!)) {
      return Anchor.leftCenter;
    } else if (position.dx < (_screenWidthMid!) &&
        position.dy < (_screenHeightMid! + _screenHeightMid! / 2)) {
      return Anchor.leftCenter;
    } else if (position.dx < (_screenWidthMid!) &&
        position.dy < (_screenHeightMid! + _screenHeightMid!)) {
      return Anchor.bottomCenter;
    }

    //CENTER RIGHT
    else if (position.dx < (_screenWidthMid! + _screenWidthMid! / 2) &&
        position.dy < (_screenHeightMid! / 2)) {
      return Anchor.topCenter;
    } else if (position.dx < (_screenWidthMid! + _screenWidthMid! / 2) &&
        position.dy < (_screenHeightMid!)) {
      return Anchor.rightCenter;
    } else if (position.dx < (_screenWidthMid! + _screenWidthMid! / 2) &&
        position.dy < (_screenHeightMid! + _screenHeightMid! / 2)) {
      return Anchor.bottomCenter;
    } else if (position.dx < (_screenWidthMid! + _screenWidthMid! / 2) &&
        position.dy < (_screenHeightMid! + _screenHeightMid!)) {
      return Anchor.rightBottom;
    }

    //RIGHT
    else if (position.dx < (_screenWidthMid! + _screenWidthMid!) &&
        position.dy < (_screenHeightMid! / 2)) {
      return Anchor.rightTop;
    } else if (position.dx < (_screenWidthMid! + _screenWidthMid!) &&
        position.dy < (_screenHeightMid!)) {
      return Anchor.rightCenter;
    } else if (position.dx < (_screenWidthMid! + _screenWidthMid!) &&
        position.dy < (_screenHeightMid! + _screenHeightMid! / 2)) {
      return Anchor.rightCenter;
    } else if (position.dx < (_screenWidthMid! + _screenWidthMid!) &&
        position.dy < (_screenHeightMid! + _screenHeightMid!)) {
      return Anchor.rightBottom;
    } else {
      return Anchor.bottomCenter;
    }
  }

  void changeStateInit() {
    _configure();
    _itemsCount = widget.items.length;
  }
}

enum Anchor {
  leftTop,
  leftCenter,
  leftBottom,
  topCenter,
  rightTop,
  rightCenter,
  rightBottom,
  bottomCenter
}
