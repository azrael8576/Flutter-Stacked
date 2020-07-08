import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutterstacked/ui/shared/app_colors.dart';

class CustomDrawerFlipScaffold extends StatefulWidget {
  final Widget drawerWidget;
  final Widget childWidget;

  CustomDrawerFlipScaffold({
    Key key,
    this.drawerWidget,
    this.childWidget,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomDrawerFlipScaffoldState();
}

class _CustomDrawerFlipScaffoldState extends State<CustomDrawerFlipScaffold>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final double maxSlide = 300.0;
  final double minDragStartEdge = 300.0;
  final double maxDragStartEdge = 300.0;
  bool _canBeDragged;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  void toggle() => _animationController.isDismissed
      ? _animationController.forward()
      : _animationController.reverse();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      onTap: toggle,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Material(
              color: AppColors.blueGrey,
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset:
                        Offset(maxSlide * (_animationController.value - 1), 0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(
                            math.pi / 2 * (1 - _animationController.value)),
                      alignment: Alignment.centerRight,
                      child: widget.drawerWidget,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(maxSlide * _animationController.value, 0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-math.pi / 2 * _animationController.value),
                      alignment: Alignment.centerLeft,
                      child: widget.childWidget,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      open();
    } else {
      close();
    }
  }

  void open() {
    _animationController.forward();
  }

  void close() {
    _animationController.reverse();
  }
}
