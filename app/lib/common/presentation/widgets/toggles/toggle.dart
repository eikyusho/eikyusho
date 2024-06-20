import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:core/core.dart';

/// A custom version of the Cupertino switch.
class Toggle extends StatefulWidget {
  const Toggle({required this.value, required this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> with TickerProviderStateMixin {
  late TapGestureRecognizer _tap;
  late HorizontalDragGestureRecognizer _drag;

  late AnimationController _positionController;
  late CurvedAnimation position;

  late AnimationController _reactionController;
  late Animation<double> _reaction;

  bool get isInteractive => widget.onChanged != null;

  // A non-null boolean value that changes to true at the end of a drag if the
  // switch must be animated to the position indicated by the widget's value.
  bool needsPositionAnimation = false;
  final dragStartBehavior = DragStartBehavior.start;

  static const double width = 39;
  static const double height = 24;

  static const double trackRadius = height / 2;
  static const double trackInnerStart = height / 2;
  static const double trackInnerEnd = width - trackInnerStart;
  static const double trackInnerLength = trackInnerEnd - trackInnerStart;

  @override
  void initState() {
    super.initState();

    _tap = TapGestureRecognizer()
      ..onTapDown = _handleTapDown
      ..onTapUp = _handleTapUp
      ..onTap = _handleTap
      ..onTapCancel = _handleTapCancel;
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..dragStartBehavior = dragStartBehavior;

    _positionController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: widget.value ? 1.0 : 0.0,
      vsync: this,
    );
    position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.linear,
    );
    _reactionController = AnimationController(
      duration: AppMisc.normalDuration,
      vsync: this,
    );
    _reaction = CurvedAnimation(
      parent: _reactionController,
      curve: Curves.ease,
    );
  }

  @override
  void didUpdateWidget(Toggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    _drag.dragStartBehavior = dragStartBehavior;

    if (needsPositionAnimation || oldWidget.value != widget.value) {
      _resumePositionAnimation(isLinear: needsPositionAnimation);
    }
  }

  void _resumePositionAnimation({bool isLinear = true}) {
    needsPositionAnimation = false;
    position
      ..curve = isLinear ? Curves.linear : Curves.ease
      ..reverseCurve = isLinear ? Curves.linear : Curves.ease.flipped;
    if (widget.value) {
      _positionController.forward();
    } else {
      _positionController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
    }
    _reactionController.forward();
  }

  void _handleTap([Intent? _]) {
    if (isInteractive) {
      widget.onChanged!(!widget.value);
      _emitVibration();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.reverse();
    }
  }

  void _handleTapCancel() {
    if (isInteractive) {
      _reactionController.reverse();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.forward();
      _emitVibration();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      position
        ..curve = Curves.linear
        ..reverseCurve = Curves.linear;
      final delta = details.primaryDelta! / trackInnerLength;
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _positionController.value -= delta;
        case TextDirection.ltr:
          _positionController.value += delta;
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    // Deferring the animation to the next build phase.
    setState(() {
      needsPositionAnimation = true;
    });
    // Call onChanged when the user's intent to change value is clear.
    if (position.value >= 0.5 != widget.value) {
      widget.onChanged!(!widget.value);
    }
    _reactionController.reverse();
  }

  void _emitVibration() {
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    if (needsPositionAnimation) {
      _resumePositionAnimation();
    }

    final inactiveColor = context.isDarkTheme
        ? context.colors.border
        : context.colors.surfaceAuxiliary;

    return Opacity(
      opacity: widget.onChanged == null ? 0.5 : 1.0,
      child: _ToggleRenderObjectWidget(
        value: widget.value,
        activeColor: context.colors.primary,
        inactiveColor: inactiveColor,
        thumbPainter: ToggleThumbPainter(
          color: context.colors.textButton,
          shadows: context.shadows.sm,
        ),
        onChanged: widget.onChanged,
        state: this,
      ),
    );
  }

  @override
  void dispose() {
    _tap.dispose();
    _drag.dispose();

    _positionController.dispose();
    _reactionController.dispose();
    super.dispose();
  }
}

class _ToggleRenderObjectWidget extends LeafRenderObjectWidget {
  const _ToggleRenderObjectWidget({
    required this.value,
    required this.activeColor,
    required this.inactiveColor,
    required this.thumbPainter,
    required this.onChanged,
    required this.state,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  final Color activeColor;
  final Color inactiveColor;
  final ToggleThumbPainter thumbPainter;
  final _ToggleState state;

  @override
  _RenderToggle createRenderObject(BuildContext context) {
    return _RenderToggle(
      value: value,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      thumbPainter: thumbPainter,
      onChanged: onChanged,
      state: state,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderToggle renderObject) {
    assert(renderObject._state == state, 'Render object state does not match.');
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..inactiveColor = inactiveColor
      ..thumbPainter = thumbPainter
      ..onChanged = onChanged;
  }
}

class _RenderToggle extends RenderConstrainedBox {
  _RenderToggle({
    required bool value,
    required Color activeColor,
    required Color inactiveColor,
    required ToggleThumbPainter thumbPainter,
    required _ToggleState state,
    ValueChanged<bool>? onChanged,
  })  : _value = value,
        _activeColor = activeColor,
        _inactiveColor = inactiveColor,
        _thumbPainter = thumbPainter,
        _onChanged = onChanged,
        _state = state,
        super(
          additionalConstraints: const BoxConstraints.tightFor(
            width: _ToggleState.width,
            height: _ToggleState.height,
          ),
        ) {
    state.position.addListener(markNeedsPaint);
    state._reaction.addListener(markNeedsPaint);
  }

  final _ToggleState _state;

  bool _value;

  bool get value => _value;

  set value(bool value) {
    if (value == _value) {
      return;
    }
    _value = value;
    markNeedsSemanticsUpdate();
  }

  Color _activeColor;

  Color get activeColor => _activeColor;

  set activeColor(Color value) {
    if (value == _activeColor) {
      return;
    }
    _activeColor = value;
    markNeedsPaint();
  }

  Color _inactiveColor;

  Color get inactiveColor => _inactiveColor;

  set inactiveColor(Color value) {
    if (value == _inactiveColor) {
      return;
    }
    _inactiveColor = value;
    markNeedsPaint();
  }

  ToggleThumbPainter _thumbPainter;

  Color get thumbColor => _thumbPainter.color;

  ToggleThumbPainter get thumbPainter => _thumbPainter;

  set thumbPainter(ToggleThumbPainter value) {
    if (value == _thumbPainter) {
      return;
    }
    _thumbPainter = value;
    markNeedsPaint();
  }

  ValueChanged<bool>? _onChanged;

  ValueChanged<bool>? get onChanged => _onChanged;

  set onChanged(ValueChanged<bool>? value) {
    if (value == _onChanged) {
      return;
    }
    final wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) {
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  bool get isInteractive => _onChanged != null;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry), 'Not supposed to handle the event.');
    if (event is PointerDownEvent && isInteractive) {
      _state._drag.addPointer(event);
      _state._tap.addPointer(event);
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    if (isInteractive) {
      config.onTap = _state._handleTap;
    }

    config
      ..isEnabled = isInteractive
      ..isToggled = _value;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final currentValue = _state.position.value;
    final currentReactionValue = _state._reaction.value;

    final visualPosition = currentValue;

    final paint = Paint()
      ..color = Color.lerp(_inactiveColor, _activeColor, currentValue)!;

    final trackRect = Rect.fromLTWH(
      offset.dx + (size.width - _ToggleState.width) / 2.0,
      offset.dy + (size.height - _ToggleState.height) / 2.0,
      _ToggleState.width,
      _ToggleState.height,
    );
    final trackRRect = RRect.fromRectAndRadius(
      trackRect,
      const Radius.circular(_ToggleState.trackRadius),
    );
    canvas.drawRRect(trackRRect, paint);

    final currentThumbExtension =
        ToggleThumbPainter.extension * currentReactionValue;
    final thumbLeft = lerpDouble(
      trackRect.left + _ToggleState.trackInnerStart - ToggleThumbPainter.radius,
      trackRect.left +
          _ToggleState.trackInnerEnd -
          ToggleThumbPainter.radius -
          currentThumbExtension,
      visualPosition,
    )!;
    final thumbRight = lerpDouble(
      trackRect.left +
          _ToggleState.trackInnerStart +
          ToggleThumbPainter.radius +
          currentThumbExtension,
      trackRect.left + _ToggleState.trackInnerEnd + ToggleThumbPainter.radius,
      visualPosition,
    )!;
    final thumbCenterY = offset.dy + size.height / 2.0;
    final thumbBounds = Rect.fromLTRB(
      thumbLeft,
      thumbCenterY - ToggleThumbPainter.radius,
      thumbRight,
      thumbCenterY + ToggleThumbPainter.radius,
    );

    _clipRRectLayer.layer = context.pushClipRRect(
      needsCompositing,
      Offset.zero,
      thumbBounds,
      trackRRect,
      (PaintingContext innerContext, Offset offset) {
        _thumbPainter.paint(innerContext.canvas, thumbBounds);
      },
      oldLayer: _clipRRectLayer.layer,
    );
  }

  final LayerHandle<ClipRRectLayer> _clipRRectLayer =
      LayerHandle<ClipRRectLayer>();

  @override
  void dispose() {
    _clipRRectLayer.layer = null;
    super.dispose();
  }
}

// final double _kTrackInnerStart = _kTrackHeight / 2.0.h;
// final double _kTrackInnerEnd = _kTrackWidth - _kTrackInnerStart;
// final double _kTrackInnerLength = _kTrackInnerEnd - _kTrackInnerStart;

class ToggleThumbPainter {
  /// Creates an object that paints an iOS-style slider thumb.
  ToggleThumbPainter({required this.color, required this.shadows});

  /// The color of the interior of the thumb.
  final Color color;

  /// The list of [BoxShadow] to paint below the thumb.
  final List<BoxShadow> shadows;

  /// Half the default diameter of the thumb.
  static const double radius = 10;

  /// The default amount the thumb should be extended horizontally when pressed.
  static const double extension = 5;

  /// Paints the thumb onto the given canvas in the given rectangle.
  ///
  /// Consider using [radius] and [extension] when deciding how large a
  /// rectangle to use for the thumb.
  void paint(Canvas canvas, Rect rect) {
    final rRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(rect.shortestSide / 2.0),
    );

    for (final shadow in shadows) {
      canvas.drawRRect(rRect.shift(shadow.offset), shadow.toPaint());
    }

    canvas
      ..drawRRect(
        rRect.inflate(0.5),
        Paint()..color = AppColors.transparent,
      )
      ..drawRRect(rRect, Paint()..color = color);
  }
}
