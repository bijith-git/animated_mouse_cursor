import 'package:flutter/material.dart';

import 'package:animated_mouse_cursor/animated_mouse_cursor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Cursor Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Animated Cursor Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            PageNavigator(
              title: "With Blend Effect",
              child: WithBlendEffect(),
            ),
            PageNavigator(
              title: "Without Blend Effect",
              child: WithOutBlendEffect(),
            ),
            PageNavigator(
              title: "Custom Decoration",
              child: CustomDecorationCursor(),
            ),
            PageNavigator(
              title: "Hover Widget Animation",
              child: WidgetHoverAnimation(),
            ),
          ],
        ),
      ),
    );
  }
}

class WithBlendEffect extends StatelessWidget {
  const WithBlendEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedCursor(
        enableBlendMask: true,
        width: 50,
        height: 50,
        child: Scaffold(
          body: Center(
            child: Text(
              "Blended Hover Effect",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ));
  }
}

class WithOutBlendEffect extends StatelessWidget {
  const WithOutBlendEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedCursor(
      width: 50,
      height: 50,
      decoration:
          const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: Scaffold(
          body: Center(
        child: Text(
          "Blended Hover Effect",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      )),
    );
  }
}

class CustomDecorationCursor extends StatelessWidget {
  const CustomDecorationCursor({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedCursor(
      decoration:
          const BoxDecoration(shape: BoxShape.rectangle, color: Colors.red),
      child: Scaffold(
          body: Center(
        child: Text(
          "Custom Decoration",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      )),
    );
  }
}

class WidgetHoverAnimation extends StatelessWidget {
  const WidgetHoverAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedCursor(
      decoration:
          const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
      child: Scaffold(
          body: Center(
        child: AnimatedCursorMouseRegion(
          heightMultiplyer: 5, //for increasing cursor size
          child: Text(
            "Hover Widget Animation",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      )),
    );
  }
}

class PageNavigator extends StatelessWidget {
  final String title;
  final Widget child;
  const PageNavigator({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => child)));
      },
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
