import 'package:flutter/material.dart';

class ExpandListTile extends StatefulWidget {
  const ExpandListTile(
      {Key key,
      this.expandedChild,
      this.collapsedChild,
      this.expandedHeight = 300.0,
      this.collapsedHeight = 70.0,
      this.duration = const Duration(milliseconds: 200),
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

class _ExpandListTileState extends State<ExpandListTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final child = _isExpanded ? widget.expandedChild : widget.collapsedChild;
    return GestureDetector(
      behavior: HitTestBehavior
          .translucent, //IMPORTANT: allows "empty" spaces to respond to events
      onTap: (() => setState(() => _isExpanded = !_isExpanded)),
      child: AnimatedContainer(
        curve: widget.curve,
        height: _isExpanded ? widget.expandedHeight : widget.collapsedHeight,
        duration: widget.duration,
        child: AnimatedSwitcher(
          duration: widget.duration,
          child: OverflowBox(
            key: ValueKey(_isExpanded),
            alignment: Alignment.topLeft,
            maxHeight:
                _isExpanded ? widget.expandedHeight : widget.collapsedHeight,
            child: child,
          ),
        ),
      ),
    );
  }
}
