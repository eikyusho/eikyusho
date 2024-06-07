import 'dart:math' show min;

import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/icon_button.dart';

enum ProgressButtonState {
  idle,
  inProgress,
  finished,
  failed;

  Color _borderColor(BuildContext context) {
    return switch (this) {
      idle => AppColors.transparent,
      inProgress || finished => context.colors.success,
      failed => context.colors.error,
    };
  }

  Color? _bgColor(BuildContext context) {
    return switch (this) {
      finished => context.colors.success,
      failed => context.colors.error,
      _ => null
    };
  }

  SvgGenImage? get _icon {
    return switch (this) {
      finished => ProgressButtonStyle.finishedIcon,
      failed => ProgressButtonStyle.failedIcon,
      _ => null,
    };
  }

  bool get isFinished => this == ProgressButtonState.finished;

  bool get isFailed => this == ProgressButtonState.failed;
}

final class ProgressButtonStyle {
  const ProgressButtonStyle._();

  static double strokeWidth = 4;
  static const Duration pulseDuration = Duration(milliseconds: 500);

  static Duration animationDuration = AppMisc.normalDuration;

  static SvgGenImage finishedIcon = Assets.icons.checkBold;
  static SvgGenImage failedIcon = Assets.icons.xBold;
}

class ProgressButton extends StatefulWidget {
  const ProgressButton({
    required this.idleIcon,
    required this.color,
    required this.progress,
    required this.onTap,
    required this.context,
    required this.state,
    super.key,
  });

  final Color color;
  final double progress;
  final SvgGenImage idleIcon;
  final ProgressButtonState state;
  final BuildContext context;
  final VoidCallback? onTap;

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final AnimationController _pulseController;
  late final Animation<double> _iconSizeAnimation;
  late final Animation<Color?> _iconColorAnimation;
  late final Animation<Color?> _iconColorPulseAnimation;

  @override
  void initState() {
    super.initState();

    final context = widget.context;

    _controller = AnimationController(
      vsync: this,
      duration: ProgressButtonStyle.animationDuration,
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: ProgressButtonStyle.pulseDuration,
    );

    _iconSizeAnimation = Tween<double>(
      begin: AppDimens.iconMd,
      end: AppDimens.iconSm,
    ).animate(_controller);

    _iconColorAnimation = ColorTween(
      begin: context.colors.textPrimary,
      end: context.colors.success.withGreen(160),
    ).animate(_controller);

    _iconColorPulseAnimation = ColorTween(
      begin: context.colors.success,
      end: context.colors.success.withGreen(160),
    ).animate(_pulseController);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          widget.state == ProgressButtonState.inProgress) {
        _pulseController
          ..forward()
          ..repeat(reverse: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _ProgressPainter(
        progress: widget.progress,
        borderColor: widget.state._borderColor(context),
      ),
      painter: _ProgressPainter(
        progress: widget.progress,
        borderColor: widget.state._borderColor(context),
      ),
      child: AnimatedBuilder(
        animation: Listenable.merge([_controller, _pulseController]),
        builder: (context, child) {
          final iconColor = _pulseController.isAnimating
              ? _iconColorPulseAnimation.value
              : _iconColorAnimation.value;

          return AppIconButton(
            widget.state._icon.getOr(widget.idleIcon),
            iconSize: _iconSizeAnimation.value,
            iconColor: iconColor,
            color: widget.state._bgColor(context).getOr(widget.color),
            onPressed: widget.onTap,
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state != widget.state) {
      switch (widget.state) {
        case ProgressButtonState.inProgress:
          _controller.forward();
        case ProgressButtonState.idle:
        case ProgressButtonState.finished:
        case ProgressButtonState.failed:
          _pulseController.stop();
          _controller.reverse();
      }
    }
  }
}

class _ProgressPainter extends CustomPainter {
  _ProgressPainter({required this.progress, required this.borderColor});

  final double progress;
  final Color borderColor;
  final double strokeWidth = ProgressButtonStyle.strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final double diameter = min(size.height, size.width);
    final radius = diameter / 2;
    final quarterRadius = diameter / 4;

    final progressPainter = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(radius, 0)
      ..lineTo(diameter - quarterRadius, 0)
      ..quadraticBezierTo(diameter, 0, diameter, quarterRadius)
      ..lineTo(diameter, diameter - quarterRadius)
      ..quadraticBezierTo(
        diameter,
        diameter,
        diameter - quarterRadius,
        diameter,
      )
      ..lineTo(quarterRadius, diameter)
      ..quadraticBezierTo(0, diameter, 0, diameter - quarterRadius)
      ..lineTo(0, quarterRadius)
      ..quadraticBezierTo(0, 0, quarterRadius, 0)
      ..lineTo(radius, 0);

    final pathMetric = path.computeMetrics().first;

    final extractPath = pathMetric.extractPath(0, pathMetric.length * progress);
    canvas.drawPath(extractPath, progressPainter);
  }

  @override
  bool shouldRepaint(covariant _ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
