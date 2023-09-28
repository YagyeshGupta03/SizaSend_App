import 'package:flutter/material.dart';

class ExitAnimationWidget extends StatefulWidget {
  final Widget widget;

  const ExitAnimationWidget({super.key, required this.widget});

  @override
  State<ExitAnimationWidget> createState() => _ExitAnimationWidgetState();
}

class _ExitAnimationWidgetState extends State<ExitAnimationWidget>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _opacity;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacity =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController!);
    startExitAnimation();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity!.value,
          child: widget.widget, // Replace with the widget you want to animate
        );
      },
    );
  }

  // Trigger the exit animation
  void startExitAnimation() {
    _animationController!.forward();
  }
}
