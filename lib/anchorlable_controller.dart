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

  /// Jumps the scroll position from its current value to the given key,
  /// without animation, and without checking if the new key is in range.
  ///
  /// Any active animation is canceled. If the user is currently scrolling, that
  /// action is canceled.
  ///
  /// If this method changes the scroll position, a sequence of start/update/end
  /// scroll notifications will be dispatched. No overscroll notifications can
  /// be generated by this method.
  ///
  /// Immediately after the jump, a ballistic activity is started, in case the
  /// key was out of range.
  void jumpToAnchor(GlobalKey anchorKey) {
    jumpTo(_getAnchorPosition(anchorKey));
  }

  /// Animates the position from its current value to the given key.
  ///
  /// Any active animation is canceled. If the user is currently scrolling, that
  /// action is canceled.
  ///
  /// The returned [Future] will complete when the animation ends, whether it
  /// completed successfully or whether it was interrupted prematurely.
  ///
  /// An animation will be interrupted whenever the user attempts to scroll
  /// manually, or whenever another activity is started, or whenever the
  /// animation reaches the edge of the viewport and attempts to overscroll. (If
  /// the [ScrollPosition] does not overscroll but instead allows scrolling
  /// beyond the extents, then going beyond the extents will not interrupt the
  /// animation.)
  ///
  /// The animation is indifferent to changes to the viewport or content
  /// dimensions.
  ///
  /// Once the animation has completed, the scroll position will attempt to
  /// begin a ballistic activity in case its key is not stable (for example,
  /// if it is scrolled beyond the extents and in that situation the scroll
  /// position would normally bounce back).
  ///
  /// The duration must not be zero. To jump to a particular key without an
  /// animation, use [jumpTo].
  ///
  /// When calling [animateTo] in widget tests, `await`ing the returned
  /// [Future] may cause the test to hang and timeout. Instead, use
  /// [WidgetTester.pumpAndSettle].
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
