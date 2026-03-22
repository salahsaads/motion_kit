import 'package:flutter/material.dart';

/// Slides [child] into its natural position from any direction.
///
/// Positive [startOffsetX] → slides in from the right.
/// Negative [startOffsetX] → slides in from the left.
/// Positive [startOffsetY] → slides in from below.
/// Negative [startOffsetY] → slides in from above.
///
/// Example:
/// ```dart
/// // Slide in from the right
/// SlideInWrapper(
///   startOffsetX: 600.0,
///   child: MyCard(),
/// )
///
/// // Slide in from the left
/// SlideInWrapper(
///   startOffsetX: -600.0,
///   child: MyCard(),
/// )
/// ```
class SlideInWrapper extends StatefulWidget {
  /// The widget to animate.
  final Widget child;

  /// Duration of the slide animation (default 3 seconds).
  final Duration duration;

  /// Starting X offset in logical pixels (default 600 = from right).
  final double startOffsetX;

  /// Ending X offset — 0 means the widget rests at its natural X position.
  final double endOffsetX;

  /// Starting Y offset in logical pixels (default 0 = no vertical movement).
  final double startOffsetY;

  /// Ending Y offset (default 0).
  final double endOffsetY;

  /// Animation curve (default [Curves.easeOut]).
  final Curve curve;

  const SlideInWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.startOffsetX = 600.0,
    this.endOffsetX = 0.0,
    this.startOffsetY = 0.0,
    this.endOffsetY = 0.0,
    this.curve = Curves.easeOut,
  });

  @override
  State<SlideInWrapper> createState() => _SlideInWrapperState();
}

class _SlideInWrapperState extends State<SlideInWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationX;
  late Animation<double> _animationY;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);

    _animationX = Tween<double>(
      begin: widget.startOffsetX,
      end: widget.endOffsetX,
    ).animate(curved);

    _animationY = Tween<double>(
      begin: widget.startOffsetY,
      end: widget.endOffsetY,
    ).animate(curved);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animationX.value, _animationY.value),
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
