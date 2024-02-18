import 'package:animated_mouse_cursor/src/animated_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'animated_cursor_state.dart';

class AnimatedMouseCursor extends StatefulWidget {
  /// This widget will listen to the mouse movement and animate the cursor according
  /// you can also create custom effect and shape by pass values to the widget as
  /// mentioned below
  const AnimatedMouseCursor({
    Key? key,
    this.child,
    this.radius = 10,
    this.curve = Curves.easeOutExpo,
    this.animationDuration = const Duration(milliseconds: 200),
  }) : super(key: key);

  /// define `animation duration` for [cursor] widget
  final Duration animationDuration;

  /// child is which the mouse cursor appears
  final Widget? child;

  /// define `animation curve` for [cursor] widget
  final Curve curve;

  final double radius;

  @override
  State<AnimatedMouseCursor> createState() => _AnimatedMouseCursorState();
}

class _AnimatedMouseCursorState extends State<AnimatedMouseCursor>
    with SingleTickerProviderStateMixin {
  Animation<double>? pointerAnimation;
  late AnimationController pointerSizeController;

  @override
  void initState() {
    pointerSizeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    pointerAnimation = CurvedAnimation(
        curve: Curves.easeInOutCubic,
        parent: Tween<double>(begin: 0, end: 1).animate(pointerSizeController));
    super.initState();
  }

  void togglePointerSize(bool hovering) async {
    if (hovering) {
      pointerSizeController.forward();
    } else {
      pointerSizeController.reverse();
    }
  }

  void _onCursorUpdate(PointerEvent event, BuildContext context) => context
      .read<AnimatedCursorProvider>()
      .updateCursorPosition(event.position);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnimatedCursorProvider(),
      child: Consumer<AnimatedCursorProvider>(
        child: widget.child,
        builder: (context, provider, child) {
          final state = provider.state;
          return Stack(
            children: [
              if (child != null) child,
              Positioned.fill(
                child: MouseRegion(
                  cursor: SystemMouseCursors.none,
                  opaque: false,
                  onHover: (e) => _onCursorUpdate(e, context),
                ),
              ),
              AnimatedBuilder(
                  animation: pointerSizeController,
                  builder: (context, snapshot) {
                    return AnimatedPointer(
                      curve: widget.curve,
                      pointerOffset: state.offset,
                      radius: 45 + 100 * pointerAnimation!.value,
                    );
                  }),
              AnimatedPointer(
                curve: widget.curve,
                pointerOffset: state.offset,
                movementDuration: widget.animationDuration,
                radius: widget.radius,
              )
            ],
          );
        },
      ),
    );
  }
}
