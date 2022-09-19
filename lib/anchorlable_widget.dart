import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'anchorlable_controller.dart';

/// Creates a vertical array of children.
///
/// The [mainAxisAlignment], [mainAxisSize], [crossAxisAlignment], and
/// [verticalDirection] arguments must not be null.
/// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
/// [textBaseline] must not be null.
///
/// The [textDirection] argument defaults to the ambient [Directionality], if
/// any. If there is no ambient directionality, and a text direction is going
/// to be necessary to disambiguate `start` or `end` values for the
/// [crossAxisAlignment], the [textDirection] must not be null.

class AnchorlableScrollColumn extends ScrollView {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  const AnchorlableScrollColumn(
      {super.key,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.textDirection,
      this.verticalDirection = VerticalDirection.down,
      this.textBaseline,
      this.children = const <Widget>[],
      super.scrollDirection = Axis.vertical,
      super.reverse = false,
      required AnchorlableController controller,
      super.primary,
      super.physics,
      super.scrollBehavior,
      super.shrinkWrap = false,
      super.center,
      super.anchor = 0.0,
      super.cacheExtent,
      super.semanticChildCount,
      super.dragStartBehavior = DragStartBehavior.start,
      super.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      super.restorationId,
      super.clipBehavior = Clip.hardEdge})
      : super(controller: controller);

  @override
  List<Widget> buildSlivers(BuildContext context) {
    return [
      AnchorlableSliverColumn(
        children: children,
      )
    ];
  }
}

/// Creates a vertical array of children.
///
/// The [mainAxisAlignment], [mainAxisSize], [crossAxisAlignment], and
/// [verticalDirection] arguments must not be null.
/// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
/// [textBaseline] must not be null.
///
/// The [textDirection] argument defaults to the ambient [Directionality], if
/// any. If there is no ambient directionality, and a text direction is going
/// to be necessary to disambiguate `start` or `end` values for the
/// [crossAxisAlignment], the [textDirection] must not be null.
class AnchorlableSliverColumn extends SliverFillRemaining {
  AnchorlableSliverColumn({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    super.hasScrollBody = false,
    super.fillOverscroll,
  }) : super(
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            textBaseline: textBaseline,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            children: [
              ...children,
            ],
          ),
        );
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
}

/// Creates a horizontal array of children.
///
/// The [mainAxisAlignment], [mainAxisSize], [crossAxisAlignment], and
/// [verticalDirection] arguments must not be null.
/// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
/// [textBaseline] must not be null.
///
/// The [textDirection] argument defaults to the ambient [Directionality], if
/// any. If there is no ambient directionality, and a text direction is going
/// to be necessary to determine the layout order (which is always the case
/// unless the row has no children or only one child) or to disambiguate
/// `start` or `end` values for the [mainAxisAlignment], the [textDirection]
/// must not be null.
class AnchorlableScrollRow extends ScrollView {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget> children;
  const AnchorlableScrollRow(
      {super.key,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.textDirection,
      this.verticalDirection = VerticalDirection.down,
      this.textBaseline,
      this.children = const <Widget>[],
      super.scrollDirection = Axis.horizontal,
      super.reverse = false,
      required AnchorlableController controller,
      super.primary,
      super.physics,
      super.scrollBehavior,
      super.shrinkWrap = false,
      super.center,
      super.anchor = 0.0,
      super.cacheExtent,
      super.semanticChildCount,
      super.dragStartBehavior = DragStartBehavior.start,
      super.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      super.restorationId,
      super.clipBehavior = Clip.hardEdge})
      : super(controller: controller);

  @override
  List<Widget> buildSlivers(BuildContext context) {
    return [
      AnchorlableSliverRow(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        textBaseline: textBaseline,
        textDirection: textDirection,
        verticalDirection: verticalDirection,
        children: children,
      )
    ];
  }
}

/// Creates a horizontal array of children.
///
/// The [mainAxisAlignment], [mainAxisSize], [crossAxisAlignment], and
/// [verticalDirection] arguments must not be null.
/// If [crossAxisAlignment] is [CrossAxisAlignment.baseline], then
/// [textBaseline] must not be null.
///
/// The [textDirection] argument defaults to the ambient [Directionality], if
/// any. If there is no ambient directionality, and a text direction is going
/// to be necessary to determine the layout order (which is always the case
/// unless the row has no children or only one child) or to disambiguate
/// `start` or `end` values for the [mainAxisAlignment], the [textDirection]
/// must not be null.
class AnchorlableSliverRow extends SliverFillRemaining {
  AnchorlableSliverRow({
    super.key,
    super.hasScrollBody = false,
    super.fillOverscroll,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline? textBaseline,
    List<Widget> children = const <Widget>[],
  }) : super(
            child: Row(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          textBaseline: textBaseline,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          children: [
            ...children,
          ],
        ));
}
