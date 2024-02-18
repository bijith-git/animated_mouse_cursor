import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animated_cursor_state.dart';

class AnimatedCursorMouseRegion extends StatefulWidget {
  /// This widget will create a custom hover animation for the widget you
  /// wraped with [AnimatedCursorMouseRegion]
  const AnimatedCursorMouseRegion({
    Key? key,
    this.child,
    this.heightMultiplyer,
    this.moveCursor = true,
    this.decoration,
  }) : super(key: key);
  final Widget? child;

  /// [heightMultiplyer] is used to determine the size of you cursor while
  /// it on hover state defualt value is `1.3` you can change accordingly
  /// if you dont want you cursor to change size then give it a value of `1`
  final double? heightMultiplyer;

  ///[moveCursor] will track the mouse move while hovering the widget and update
  /// postion ,defualt value is `true` you can also create a magnetic effect by
  /// changeing its value to `false` so that when it hover the cursor automatically
  /// move to the center
  final bool moveCursor;

  ///[decoration] create a custom decoration for that widget if you pass it a
  ///empty decoration like [BoxDecoration()] the effect will be cancel .
  ///you need to ass `BoxShape` or elese it shows a flutter assert error in
  ///box decoration
  final BoxDecoration? decoration;

  @override
  State<AnimatedCursorMouseRegion> createState() =>
      _AnimatedCursorMouseRegionState();
}

class _AnimatedCursorMouseRegionState extends State<AnimatedCursorMouseRegion> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnimatedCursorProvider>();

    return MouseRegion(
      key: _key,
      cursor: SystemMouseCursors.none,
      opaque: false,
      onHover: (e) => cubit.changeCursor(_key,
          decoration: widget.decoration,
          event: e,
          kDefualtHover: widget.heightMultiplyer ?? 1.3,
          moveCursor: widget.moveCursor),
      onExit: (_) => cubit.resetCursor(),
      child: widget.child,
    );
  }
}
