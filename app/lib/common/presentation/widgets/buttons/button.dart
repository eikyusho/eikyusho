import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/presentation/widgets/interactions/clickable_element.dart';

enum ButtonType { primary, secondary }

enum ButtonSize {
  small,
  large;

  double get _value =>
      this == ButtonSize.small ? AppDimens.buttonLg : AppDimens.buttonXl;
}

enum ButtonState {
  enabled,
  disabled;

  Color _color(BuildContext context, ButtonType type) {
    return switch (this) {
      enabled => type == ButtonType.primary
          ? context.colors.primary
          : context.colors.surfaceSecondary,
      disabled => context.colors.surfaceAuxiliary,
    };
  }
}

class Button extends StatelessWidget {
  const Button({
    required this.text,
    required this.onTap,
    this.type = ButtonType.primary,
    this.state = ButtonState.enabled,
    this.size = ButtonSize.large,
    super.key,
  });

  final String text;
  final ButtonType type;
  final ButtonState state;
  final ButtonSize size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClickableElement(
      onTap: state == ButtonState.disabled ? null : onTap,
      animation: _getAnimation(state),
      borderRadius: AppDimens.radiusMd,
      child: Container(
        height: size._value,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: state._color(context, type),
          boxShadow: context.shadows.md,
        ),
        child: Text(text).textStyle(
          context.textTheme.bodyLg.medium,
          color: context.colors.textButton,
        ),
      ),
    );
  }

  ClickableElementAnimation _getAnimation(ButtonState state) {
    return switch (state) {
      ButtonState.disabled => ClickableElementAnimation.none,
      ButtonState.enabled => ClickableElementAnimation.shrink
    };
  }
}
