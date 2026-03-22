import 'package:flutter/material.dart';

/// Continuously scales [child] between [minScale] and [maxScale],
/// creating a "heartbeat" or breathing pulse effect.
///
/// Example:
/// ```dart
/// PulseAnimation(
///   child: Icon(Icons.favorite, color: Colors.red),
/// )
/// ```
class PulseAnimation extends StatefulWidget {
  /// The widget to animate.
  final Widget child;

  /// Duration of one pulse cycle (default 1 second).
  final Duration duration;

  /// Smallest scale value (default 0.8).
  final double minScale;

  /// Largest scale value (default 1.2).
  final double maxScale;

  const PulseAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.minScale = 0.8,
    this.maxScale = 1.2,
  });

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: widget.minScale,
      end: widget.maxScale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scaleAnimation, child: widget.child);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
