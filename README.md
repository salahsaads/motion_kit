# motion_kit

<p align="center">
  <img src="https://img.shields.io/pub/v/motion_kit?color=7C6EF5&labelColor=0D0D0D&style=for-the-badge" alt="pub version"/>
  <img src="https://img.shields.io/pub/likes/motion_kit?color=EC407A&labelColor=0D0D0D&style=for-the-badge" alt="pub likes"/>
  <img src="https://img.shields.io/pub/points/motion_kit?color=66BB6A&labelColor=0D0D0D&style=for-the-badge" alt="pub points"/>
  <img src="https://img.shields.io/badge/platform-flutter-42A5F5?labelColor=0D0D0D&style=for-the-badge" alt="platform"/>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/salahsaads/motion_kit/master/motion_kit_demo.gif" width="360" alt="motion_kit demo"/>
</p>

> A collection of reusable Flutter animation wrapper widgets. Drop any of them around an existing widget to instantly add motion.

---

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

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  motion_kit: ^1.0.1
```

Then import:

```dart
import 'package:motion_kit/motion_kit.dart';
```

---

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

---

## Author

**Salah Saad**
- GitHub: [@salahsaads](https://github.com/salahsaads/motion_kit)
- Email: salah.saad.kassab@gmail.com

---

## License

MIT © 2024 Salah Saad