import 'package:flutter/material.dart';

/// Rotates [child] by [turns] full revolutions over [duration].
///
/// Example:
/// ```dart
/// // Spin a logo 3 times on load
/// RotateWrapper(
///   turns: 3,
///   duration: Duration(seconds: 2),
///   child: FlutterLogo(size: 80),
/// )
/// ```
class RotateWrapper extends StatefulWidget {
  /// The widget to animate.
  final Widget child;

  /// Duration of a single full revolution (total duration = duration × turns).
  final Duration duration;

  /// Starting angle in radians (default 0.0).
  final double initialAngle;

  /// Ending angle per turn in radians (default 2π = one full revolution).
  final double finalAngle;

  /// Number of complete rotations to perform (default 1).
  final int turns;

  const RotateWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 1),
    this.initialAngle = 0.0,
    this.finalAngle = 2 * 3.14159,
    this.turns = 1,
  });

  @override
  State<RotateWrapper> createState() => _RotateWrapperState();
}

class _RotateWrapperState extends State<RotateWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration * widget.turns,
    );

    _animation = Tween<double>(
      begin: widget.initialAngle,
      end: widget.finalAngle * widget.turns,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(angle: _animation.value, child: child);
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
