import 'package:flutter/material.dart';

class CustomDrawerWidget extends StatefulWidget {
  final Widget drawerWidget;
  final Widget childWidget;

  CustomDrawerWidget({
    Key key,
    this.drawerWidget,
    this.childWidget,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final double maxSlide = 225.0;
  final double minDragStartEdge = 225.0;
  final double maxDragStartEdge = 225.0;
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
            double slide = maxSlide * _animationController.value;
            double scale = 1 - (_animationController.value * 0.3);
            return Stack(
              children: <Widget>[
                widget.drawerWidget,
                Transform(
                  transform: Matrix4.identity()
                    ..translate(slide)
                    ..scale(scale),
                  alignment: Alignment.centerLeft,
                  child: widget.childWidget,
                ),
              ],
            );
          }),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed && details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted && details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if(_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx / MediaQuery.of(context).size.width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      open();
    } else {
      close();
    }
  }

  void open() {_animationController.forward();}

  void close() {_animationController.reverse();}
}
