import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'animated_mouse_cursor_method_channel.dart';

abstract class AnimatedMouseCursorPlatform extends PlatformInterface {
  /// Constructs a AnimatedMouseCursorPlatform
  AnimatedMouseCursorPlatform() : super(token: _token);

  static final Object _token = Object();

  static AnimatedMouseCursorPlatform _instance =
      MethodChannelAnimatedMouseCursor();

  /// The default instance of [AnimatedMouseCursorPlatform] to use.
  ///
  /// Defaults to [MethodChannelAnimatedMouseCursor].
  static AnimatedMouseCursorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AnimatedMouseCursorPlatform] when
  /// they register themselves.
  static set instance(AnimatedMouseCursorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
