import 'package:flutter/material.dart';

class AnchorlableController extends ScrollController
    implements
        AnchorlableControllerInterface,
        AnchorlableControllerBindingInterface {
  AnchorlableController({
    this.absoluteKey,
    this.initialAnchorKey,
    String? debugLabel,
    bool keepScrollOffset = true,
    this.endKey,
  }) : super(debugLabel: debugLabel, keepScrollOffset: keepScrollOffset) {
    if (absoluteKey != null) {
      initialJump();
    }
  }
  GlobalKey? initialAnchorKey;
  GlobalKey? absoluteKey;
  GlobalKey? endKey;
  @override
  void jumpToAnchor(GlobalKey anchorKey) {
    jumpTo(_getAnchorPosition(anchorKey));
  }

  @override
  Future<void> animateToAnchor(GlobalKey anchorKey,
      {required Duration duration, required Curve curve}) async {
    await animateTo(_getAnchorPosition(anchorKey),
        duration: duration, curve: curve);
  }

  Offset _key2offset(GlobalKey key) {
    final box = _key2box(key);
    return box.localToGlobal(Offset.zero);
  }

  RenderBox _key2box(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) {
      throw ErrorHint('You need to register $key in some widget.');
    }
    return context.findRenderObject() as RenderBox;
  }

  double _getAnchorPosition(GlobalKey anchorKey) {
    final anchorOffset = _key2offset(anchorKey);
    final absoluteOffset = _key2offset(absoluteKey!);
    final endOffset = _key2offset(endKey!);
    final endPoint =
        super.position.axis == Axis.vertical ? endOffset.dy : endOffset.dx;
    final diff = super.position.axis == Axis.vertical
        ? endPoint - anchorOffset.dy
        : endPoint - anchorOffset.dx;
    final jumpingPosition = super.position.axis == Axis.vertical
        ? anchorOffset.dy - absoluteOffset.dy + super.offset
        : anchorOffset.dx - absoluteOffset.dx + super.offset;
    if (diff < super.position.viewportDimension) {
      return endPoint - super.position.viewportDimension;
    }
    return jumpingPosition;
  }

  @override
  void setAbsolute(GlobalKey<State<StatefulWidget>> absoluteKey) {
    this.absoluteKey = absoluteKey;
  }

  @override
  void initialJump() {
    if (initialAnchorKey != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        jumpToAnchor(initialAnchorKey!);
      });
    }
  }

  @override
  void setEnd(GlobalKey<State<StatefulWidget>> endKey) {
    this.endKey = endKey;
  }
}

abstract class AnchorlableControllerInterface implements ScrollController {
  void jumpToAnchor(GlobalKey anchorKey);
  Future<void> animateToAnchor(GlobalKey anchorKey,
      {required Duration duration, required Curve curve});
}

abstract class AnchorlableControllerBindingInterface {
  void setAbsolute(GlobalKey absoluteKey);
  void initialJump();
  void setEnd(GlobalKey endKey);
}
