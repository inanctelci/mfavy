import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    void initState() {
      super.initState();
      controller = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.horizontal,
          resizeDuration: const Duration(milliseconds: 200),
          onResize: () {
            print('Widget resized in direction: ');
          },
          onDismissed: (direction) {
            setState(() {});
          },
          child: AnimatedSwitcher(
            reverseDuration: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: Text(
              'Swipeable Text',
              key: UniqueKey(),
              style: const TextStyle(
                fontSize: 24.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
