import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'blended_mask.dart';

// import 'Blended_mask.dart';

const black = Color(0xff000000);
const white = Color(0xffffffff);

class AnimatedCursorState {
  const AnimatedCursorState({
    this.offset = Offset.zero,
    this.size = kDefaultSize,
    this.decoration = kDefaultDecoration,
  });

  static const Size kDefaultSize = Size(20, 20);
  static const BoxDecoration kDefaultDecoration = BoxDecoration(
    // borderRadius: BorderRadius.all(Radius.circular(90)),
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

class AnimatedCursor extends StatelessWidget {
  final Widget? child;
  final bool enableBlendMask;
  final BoxDecoration? decoration;
  final double? height;
  final double? width;
  final Curve curve;
  final Duration animationDuration;
  const AnimatedCursor({
    Key? key,
    this.child,
    this.enableBlendMask = false,
    this.decoration,
    this.height,
    this.width,
    this.curve = Curves.easeInOut,
    this.animationDuration = const Duration(milliseconds: 150),
  }) : super(key: key);

  void _onCursorUpdate(PointerEvent event, BuildContext context) => context
      .read<AnimatedCursorProvider>()
      .updateCursorPosition(event.position);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AnimatedCursorProvider(),
      child: Consumer<AnimatedCursorProvider>(
        child: child,
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
              Visibility(
                visible: state.offset != Offset.zero,
                child: AnimatedPositioned(
                  left: width == null
                      ? state.offset.dx - state.size.width / 2
                      : state.offset.dx - width! / 2,
                  top: height == null
                      ? state.offset.dy - state.size.height / 2
                      : state.offset.dy - height! / 2,
                  width: width ?? state.size.width,
                  height: height ?? state.size.height,
                  duration: animationDuration,
                  child: IgnorePointer(
                    child: enableBlendMask
                        ? BlendMask(
                            blendMode: BlendMode.difference,
                            child: AnimatedContainer(
                              duration: animationDuration,
                              curve: curve,
                              width: width ?? state.size.width,
                              height: height ?? state.size.height,
                              decoration: decoration ?? state.decoration,
                            ),
                          )
                        : AnimatedContainer(
                            duration: animationDuration,
                            curve: curve,
                            width: width ?? state.size.width,
                            height: height ?? state.size.height,
                            decoration: decoration ?? state.decoration),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class AnimatedCursorMouseRegion extends StatefulWidget {
  const AnimatedCursorMouseRegion({
    Key? key,
    this.child,
    this.heightMultiplyer,
    this.moveCursor = true,
    this.decoration,
  }) : super(key: key);

  final Widget? child;
  final double? heightMultiplyer;
  final bool moveCursor;
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