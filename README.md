# animated_mouse_cursor

[![pub package](https://img.shields.io/pub/v/animated_mouse_cursor.svg)](https://pub.dartlang.org/packages/animated_mouse_cursor)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

This Flutter package create beautiful custom mouse cursor on flutter web

### Demo

<IMG height="400px" src="https://raw.githubusercontent.com/bijith-git/animated_mouse_cursor/master/example/demo%20video/demo.gif"></IMG>

## Installation

Add this to your `pubspec.yaml` file:

```yaml
dependencies:
  animated_mouse_cursor: <latest-version>
```

or

```shell
flutter pub add animated_mouse_cursor
```

## Implementation

Import the package in your Dart file:

```yaml
import 'package:animated_mouse_cursor/animated_mouse_cursor.dart';
```

## Usage

The AnimatedCursor widget allows you to create a defualt cursor for your mouse you can wrap this widget in `MaterialApp` or a single `Widget`.

```dart
      MaterialApp(
      title: 'Animated Cursor Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true),
      home: const AnimatedCursor(
          enableBlendMask: false,
          child: MyHomePage(title: 'Animated Cursor Demo')));

```

The AnimatedCursorMouseRegion widget create a custom animation for your selected widget by wraping that widget.

```dart
    AnimatedCursorMouseRegion(
    decoration: const BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
    child: Text(
      'custom effect to cursor',
      style: Theme.of(context).textTheme.headlineMedium,
    ),
    ),
```
