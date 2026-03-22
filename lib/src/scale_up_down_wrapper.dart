import 'package:flutter/material.dart';

/// Continuously oscillates [child] between [initialScale] and [finalScale].
///
/// Unlike [PulseAnimation] (which uses [ScaleTransition]), this widget
/// uses [Transform.scale] directly, giving you full control over both
/// scale endpoints without being constrained to [0, 1].
///
/// Example:
/// ```dart
/// ScaleUpDownWrapper(
///   initialScale: 0.9,
///   finalScale: 1.1,
///   child: Text('Breathing button'),
/// )
/// ```
class ScaleUpDownWrapper extends StatefulWidget {
  /// The widget to animate.
  final Widget child;

  /// Duration of one half-cycle (default 1 second).
  final Duration duration;

  /// Scale at the smaller end of the loop (default 0.8).
  final double initialScale;

  /// Scale at the larger end of the loop (default 1.0).
  final double finalScale;

  const ScaleUpDownWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.initialScale = 0.8,
    this.finalScale = 1.0,
  });

  @override
  State<ScaleUpDownWrapper> createState() => _ScaleUpDownWrapperState();
}

class _ScaleUpDownWrapperState extends State<ScaleUpDownWrapper>
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
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
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
