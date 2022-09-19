# flutter_anchorlable
![Videotogif (1)](https://user-images.githubusercontent.com/82094614/190932053-f3228df0-d264-4427-a17b-bce43f130fa7.gif)
This package provides freely scrollable widgets and their controllers, with key as the anchor.  
You can play the demo [here](https://yama-yeah.github.io/flutter_anchorlable/#/)!
# install
In the pubspec.yaml of your flutter project, add the following dependency:
```yaml
dependencies:
  flutter_anchorlable: <latest_version>
```
In your library add the following import:
```dart
import 'package:flutter_anchorlable/flutter_anchorlable.dart';
```
# Usage
`AnchorlableController` is a controller that enables scrolling for widgets owned by the attached client.  
By specifying `initialAnchorKey`, the initial scroll position of the attached client can be specified.

```dart
final controller=AnchorlableController();
```

`jumpToAnchor` jumps to the specified key.

```dart
controller.jumpToAnchor(anchorKey);
```

`animateToAnchor` performs animated scrolling for widgets with the target key.  
If you are not sure which Curve to choose, you may find the [this](https://api.flutter.dev/flutter/animation/Curves-class.html) helpful.

```dart
onPressed: () async {
  await controller.animateToAnchor(anchor,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn);
}
```

`AnchorlableScrollColumn `can be used to arrange widgets vertically.  
It requires a `Key` and `AnchorlableController`.  
By using `AnchorlableController`, it is possible to scroll the `widget` with the `Key` existing in the `children`.
```dart
final controller=AnchorlableController();
const bodyKey = GlobalObjectKey('body');
const anchorKey = GlobalObjectKey('anchor');
AnchorlableScrollColumn(
  controller:controller,
  key: bodyKey,
  children:[
    ...
    Container(
      child: Text(
        key:anchorKey,
        'Widgets you want to anchor'
        ),
    ),
    ...
  ],
)
```

`AnchorlableScrollRow` is a side-by-side version of `AnchorlableScrollColumn`.

```dart
final controller=AnchorlableController();
const bodyKey = GlobalObjectKey('body');
const anchorKey = GlobalObjectKey('anchor');
AnchorlableScrollRow(
  controller:controller,
  key: bodyKey,
  children:[
    ...
    Container(
      child: Text(
        key:anchorKey,
        'Widgets you want to anchor'
        ),
    ),
    ...
  ],
);
```

# Contact
If you have anything you want to inform me ([@yama-yeah](https://github.com/yama-yeah)), such as suggestions to enhance this package or functionalities you want etc, feel free to make [issues on GitHub](https://github.com/yama-yeah/flutter_anchorlable/issues)