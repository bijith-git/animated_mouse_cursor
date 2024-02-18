import 'package:flutter/material.dart';

import 'animated_pointer.dart';

class CursorBlending extends StatefulWidget {
  final Widget child;
  final bool enableHoverEffect;
  const CursorBlending(
      {super.key, required this.child, this.enableHoverEffect = false});

  @override
  State<CursorBlending> createState() => _CursorBlendingState();
}

class _CursorBlendingState extends State<CursorBlending>
    with SingleTickerProviderStateMixin {
  Offset? pointerOffset;
  late AnimationController pointerSizeController;
  Animation<double>? pointerAnimation;
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      opaque: false,
      cursor: SystemMouseCursors.none,
      onHover: (e) => setState(() => pointerOffset = e.localPosition),
      onExit: (e) => setState(() => pointerOffset = Offset.zero),
      child: Stack(
        children: [
          widget.child,
          if (pointerOffset != null) ...[
            AnimatedBuilder(
                animation: pointerSizeController,
                builder: (context, snapshot) {
                  return AnimatedPointer(
                    pointerOffset: pointerOffset ?? Offset.zero,
                    radius: 45 + 100 * pointerAnimation!.value,
                  );
                }),
            AnimatedPointer(
              pointerOffset: pointerOffset ?? Offset.zero,
              movementDuration: const Duration(milliseconds: 200),
              radius: 10,
            )
          ]
        ],
      ),
    );
  }
}
