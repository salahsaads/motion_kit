import 'package:flutter/material.dart';
import 'package:motion_kit/motion_kit.dart';

void main() => runApp(const FlutterAnimationsDemo());

class FlutterAnimationsDemo extends StatelessWidget {
  const FlutterAnimationsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Animations')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // ── 1. PendulumAnimationWrapper ─────────────────────────────
          _Section(
            label: 'PendulumAnimationWrapper',
            child: PendulumAnimationWrapper(
              child: const Icon(Icons.watch_rounded, size: 64),
            ),
          ),

          // ── 2. BounceOutFromTop ─────────────────────────────────────
          _Section(
            label: 'BounceOutFromTop',
            child: BounceOutFromTop(
              startOffsetY: -120,
              duration: const Duration(seconds: 2),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          // ── 3. PulseAnimation ───────────────────────────────────────
          _Section(
            label: 'PulseAnimation',
            child: PulseAnimation(
              child: const Icon(Icons.favorite, color: Colors.red, size: 64),
            ),
          ),

          // ── 4. RotateWrapper ────────────────────────────────────────
          _Section(
            label: 'RotateWrapper (3 turns)',
            child: RotateWrapper(
              turns: 3,
              duration: const Duration(seconds: 2),
              child: const FlutterLogo(size: 64),
            ),
          ),

          // ── 5. ScaleWrapper ─────────────────────────────────────────
          _Section(
            label: 'ScaleWrapper (pop-in)',
            child: ScaleWrapper(
              duration: const Duration(milliseconds: 600),
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 40),
              ),
            ),
          ),

          // ── 6. ScaleUpDownWrapper ───────────────────────────────────
          _Section(
            label: 'ScaleUpDownWrapper (breathe)',
            child: ScaleUpDownWrapper(
              initialScale: 0.85,
              finalScale: 1.15,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Text(
                  'Breathing Button',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),

          // ── 7. SlideInWrapper ───────────────────────────────────────
          _Section(
            label: 'SlideInWrapper (from right)',
            child: SlideInWrapper(
              startOffsetX: 300,
              duration: const Duration(milliseconds: 800),
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.indigo.shade100,
                child: const Text('Slid in from the right!'),
              ),
            ),
          ),

          // ── 8. AnimatedItem (staggered list) ────────────────────────
          const Padding(
            padding: EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              'AnimatedItem — staggered list',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...List.generate(
            5,
            (i) => AnimatedItem(
              index: i,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${i + 1}')),
                  title: Text('Staggered item ${i + 1}'),
                  subtitle: const Text('Fades + slides up with a delay'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper ────────────────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String label;
  final Widget child;

  const _Section({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 12),
          Center(child: child),
          const Divider(height: 32),
        ],
      ),
    );
  }
}
