import 'package:flutter/material.dart';

/// Wraps [child] in a pendulum-swing animation.
///
/// The widget swings from the center, reaches ±[maxAngleDegrees] on each side,
/// and comes to rest back at center — all within [duration].
///
/// Example:
/// ```dart
/// PendulumAnimationWrapper(
///   child: Icon(Icons.watch, size: 64),
/// )
/// ```
class PendulumAnimationWrapper extends StatefulWidget {
  /// The widget to animate.
  final Widget child;

  /// Total duration of one full pendulum swing sequence.
  final Duration duration;

  /// Maximum swing angle in degrees (default 15°).
  final double maxAngleDegrees;

  const PendulumAnimationWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.maxAngleDegrees = 15.0,
  });

  @override
  State<PendulumAnimationWrapper> createState() =>
      _PendulumAnimationWrapperState();
}

class _PendulumAnimationWrapperState extends State<PendulumAnimationWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pendulumAnimation;

  static const double _degreesToRadians = 0.0174533;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    final double angle = widget.maxAngleDegrees;

    _pendulumAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -angle), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -angle, end: angle), weight: 2),
      TweenSequenceItem(tween: Tween(begin: angle, end: -angle), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -angle, end: angle), weight: 2),
      TweenSequenceItem(tween: Tween(begin: angle, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pendulumAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _pendulumAnimation.value * _degreesToRadians,
          child: child,
        );
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
