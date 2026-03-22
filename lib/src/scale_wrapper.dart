import 'package:flutter/material.dart';

/// Animates [child] from [initialScale] to [finalScale] once.
///
/// Useful for pop-in / appear effects.
///
/// Example:
/// ```dart
/// ScaleWrapper(
///   initialScale: 0.0,
///   finalScale: 1.0,
///   child: Card(...),
/// )
/// ```
class ScaleWrapper extends StatefulWidget {
  /// The widget to animate.
  final Widget child;

  /// Duration of the scale animation (default 300 ms).
  final Duration duration;

  /// Scale at the start of the animation (default 0.0).
  final double initialScale;

  /// Scale at the end of the animation (default 1.0).
  final double finalScale;

  const ScaleWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.initialScale = 0.0,
    this.finalScale = 1.0,
  });

  @override
  State<ScaleWrapper> createState() => _ScaleWrapperState();
}

class _ScaleWrapperState extends State<ScaleWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<double>(
      begin: widget.initialScale,
      end: widget.finalScale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(scale: _animation.value, child: child);
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
