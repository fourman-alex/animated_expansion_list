import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExpandListTile extends StatefulWidget {
  const ExpandListTile(
      {Key key,
      this.expandedChild,
      this.collapsedChild,
      this.expandedHeight = 300.0,
      this.collapsedHeight = 70.0,
      this.duration = const Duration(milliseconds: 500),
      this.curve = Curves.ease})
      : super(key: key);

  final Widget expandedChild;
  final Widget collapsedChild;
  final double expandedHeight;
  final double collapsedHeight;
  final Duration duration;
  final Curve curve;

  @override
  _ExpandListTileState createState() => _ExpandListTileState();
}

class _ExpandListTileState extends State<ExpandListTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _flipAnimation;
  Animation _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _flipAnimation = CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.ease));
    _expandAnimation = CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.ease));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior
          .translucent, //IMPORTANT: allows "empty" spaces to respond to events
      onTap: (() => setState(() {
            _toggle();
            // _isExpanded = !_isExpanded;
          })),
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          var currentHeight = widget.collapsedHeight +
              (widget.expandedHeight - widget.collapsedHeight) *
                  _expandAnimation.value;
          return SizedBox(
            // height: widget.expandedHeight,
            height: currentHeight,
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -widget.collapsedHeight * (_flipAnimation.value)),
                  child: Transform(
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.identity()
                      ..setEntry(2, 3, 0.001)
                      ..rotateX(-math.pi / 2 * _flipAnimation.value),
                    child: widget.collapsedChild,
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -widget.collapsedHeight * (_flipAnimation.value - 1)),
                  child: Transform(
                    alignment: Alignment.topCenter,
                    transform: Matrix4.identity()
                      ..setEntry(2, 3, 0.001)
                      ..rotateX(math.pi * (1 - _flipAnimation.value) / 2),
                    child: OverflowBox(
                      maxHeight: widget.expandedHeight,
                      child: widget.expandedChild,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _toggle() {
    if (_controller.status == AnimationStatus.completed || _controller.status == AnimationStatus.forward){
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }
}
