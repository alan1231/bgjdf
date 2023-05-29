import 'package:flutter/material.dart';

class DraggableFloatingActionButton extends StatefulWidget {
  final Widget child;
  final Offset initialOffset;
  final VoidCallback onPressed;

  DraggableFloatingActionButton({
    required this.child,
    required this.initialOffset,
    required this.onPressed,
    required GlobalKey<State<StatefulWidget>> parentKey,
  });

  @override
  State<StatefulWidget> createState() => _DraggableFloatingActionButtonState();
}

class _DraggableFloatingActionButtonState
    extends State<DraggableFloatingActionButton> {
  bool _isDragging = false;
  late Offset _offset;
  late Size _screenSize;

  @override
  void initState() {
    super.initState();
    _offset = widget.initialOffset;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenSize = MediaQuery.of(context).size;
    _offset = const Offset(0, 0);
  }

  void _updatePosition(DragUpdateDetails details) {
    double newOffsetX = _offset.dx + details.delta.dx;
    double newOffsetY = _offset.dy + details.delta.dy;

    // 边界检查，确保按钮在屏幕范围内
    newOffsetX = newOffsetX.clamp(0.0, _screenSize.width - 80); // 假设按钮宽度为80
    newOffsetY = newOffsetY.clamp(0.0, _screenSize.height - 160); // 假设按钮高度为80

    setState(() {
      _offset = Offset(newOffsetX, newOffsetY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          _updatePosition(details);

          setState(() {
            _isDragging = true;
          });
        },
        onPanEnd: (details) {
          if (_isDragging) {
            setState(() {
              _isDragging = false;
            });
          } else {
            widget.onPressed();
          }
        },
        child: Container(
          width: 80,
          height: 80,
          child: InkWell(
            onTap: widget.onPressed,
            child: Center(child: widget.child),
          ),
        ),
      ),
    );
  }
}
