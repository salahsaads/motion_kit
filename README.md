# motion_kit

A collection of reusable Flutter animation wrapper widgets. Drop any of them around an existing widget to instantly add motion.

## Widgets

| Widget | Effect |
|---|---|
| `PendulumAnimationWrapper` | Swings child like a pendulum, then settles |
| `BounceOutFromTop` | Drops child from above with a bounce landing |
| `PulseAnimation` | Continuously scales child in and out (heartbeat) |
| `RotateWrapper` | Rotates child by N full turns, then stops |
| `ScaleWrapper` | Scales child from any start scale to any end scale (once) |
| `ScaleUpDownWrapper` | Continuously oscillates child between two scales |
| `SlideInWrapper` | Slides child in from any direction |
| `AnimatedItem` | Staggered fade + slide-up for list/grid items |

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  motion_kit:
    path: ../motion_kit   # local path, or use pub.dev when published
```

Then import:

```dart
import 'package:motion_kit/motion_kit.dart';
```

## Usage examples

### PendulumAnimationWrapper
```dart
PendulumAnimationWrapper(
  maxAngleDegrees: 20,
  child: Icon(Icons.watch_rounded, size: 64),
)
```

### BounceOutFromTop
```dart
BounceOutFromTop(
  startOffsetY: -600,
  duration: Duration(seconds: 2),
  child: MyWidget(),
)
```

### PulseAnimation
```dart
PulseAnimation(
  minScale: 0.9,
  maxScale: 1.1,
  child: Icon(Icons.favorite, color: Colors.red),
)
```

### RotateWrapper
```dart
RotateWrapper(
  turns: 3,
  duration: Duration(seconds: 2),
  child: FlutterLogo(size: 80),
)
```

### ScaleWrapper
```dart
ScaleWrapper(
  initialScale: 0.0,
  finalScale: 1.0,
  duration: Duration(milliseconds: 500),
  child: Card(...),
)
```

### ScaleUpDownWrapper
```dart
ScaleUpDownWrapper(
  initialScale: 0.9,
  finalScale: 1.1,
  child: ElevatedButton(onPressed: () {}, child: Text('Tap me')),
)
```

### SlideInWrapper
```dart
// From right
SlideInWrapper(startOffsetX: 600, child: MyWidget())

// From left
SlideInWrapper(startOffsetX: -600, child: MyWidget())

// From bottom
SlideInWrapper(startOffsetX: 0, startOffsetY: 400, child: MyWidget())
```

### AnimatedItem (staggered list)
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => AnimatedItem(
    index: index,
    child: ListTile(title: Text(items[index])),
  ),
)
```

## License

MIT
