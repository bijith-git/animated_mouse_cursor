
import 'package:animated_mouse_cursor/src/constants.dart';
import 'package:flutter/widgets.dart';

class AnimatedCursorState {
  const AnimatedCursorState({
    this.offset = Offset.zero,
    this.size = kDefaultSize,
    this.decoration = kDefaultDecoration,
  });

  static const Size kDefaultSize = Size(20, 20);
  static const BoxDecoration kDefaultDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: white,
  );

  final BoxDecoration decoration;
  final Offset offset;
  final Size size;
}

class AnimatedCursorProvider extends ChangeNotifier {
  AnimatedCursorProvider();

  AnimatedCursorState state = const AnimatedCursorState();

  void changeCursor(GlobalKey key,
      {BoxDecoration? decoration,
      PointerEvent? event,
      bool moveCursor = true,
      double? kDefualtHover}) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    state = AnimatedCursorState(
      size: renderBox.size * kDefualtHover!,
      offset: moveCursor
          ? event!.position
          : renderBox
              .localToGlobal(Offset.zero)
              .translate(renderBox.size.width / 2, renderBox.size.height / 2),
      decoration: decoration ?? AnimatedCursorState.kDefaultDecoration,
    );
    notifyListeners();
  }

  void resetCursor() {
    state = const AnimatedCursorState();
    notifyListeners();
  }

  void updateCursorPosition(Offset pos) {
    state = AnimatedCursorState(offset: pos);
    notifyListeners();
  }
}
