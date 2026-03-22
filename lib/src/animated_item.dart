import 'package:flutter/material.dart';

/// Staggered fade + slide-up animation for list or grid items.
///
/// Each item delays its entrance by `delay × index`, so items appear
/// one after another instead of all at once.
///
/// Example:
/// ```dart
/// ListView.builder(
///   itemCount: items.length,
///   itemBuilder: (context, index) {
///     return AnimatedItem(
///       index: index,
///       child: ListTile(title: Text(items[index])),
///     );
///   },
/// )
/// ```
class AnimatedItem extends StatefulWidget {
  /// The widget to animate.
  final Widget child;

  /// Position in the list — controls how long the initial delay is.
  final int index;

  /// Base delay multiplied by [index] to stagger siblings (default 200 ms).
  final Duration delay;

  /// Duration of each item's individual animation (default 600 ms).
  final Duration duration;

  /// Vertical slide distance in logical pixels (default 30).
  ///
  /// The widget starts [offset] pixels below its rest position and
  /// slides upward into place.
  final double offset;

  const AnimatedItem({
    super.key,
    required this.child,
    required this.index,
    this.delay = const Duration(milliseconds: 200),
    this.duration = const Duration(milliseconds: 600),
    this.offset = 30,
  });

  @override
  State<AnimatedItem> createState() => _AnimatedItemState();
}

class _AnimatedItemState extends State<AnimatedItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);

    _slide = Tween<Offset>(
      begin: Offset(0, widget.offset / 100),
      end: Offset.zero,
    ).animate(curved);

    Future.delayed(widget.delay * widget.index, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: MouseRegion(
          onEnter: (_) => _controller.forward(from: 0.9),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
