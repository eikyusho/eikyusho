import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/presentation/widgets/interactions/clickable_element.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    required this.text,
    required this.onTap,
    this.dangerAction = false,
    super.key,
  });

  final SvgGenImage icon;
  final String text;
  final bool dangerAction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ClickableElement(
      onTap: onTap,
      borderRadius: AppDimens.radiusLg,
      child: Container(
        width: double.infinity,
        height: AppDimens.buttonLg,
        padding: const EdgeInsets.all(AppDimens.md),
        decoration: BoxDecoration(
          color: context.colors.surface,
          boxShadow: context.shadows.sm,
        ),
        child: Row(
          children: [
            icon.svg(
              colorFilter: ColorFilter.mode(
                _getColor(context, danger: dangerAction),
                AppMisc.blendMode,
              ),
              height: AppDimens.iconLg,
              width: AppDimens.iconLg,
            ),
            Text(text).textStyle(
              context.textTheme.bodyLg.medium,
              color: _getColor(
                context,
                danger: dangerAction,
              ),
            ),
          ],
        ).gap(AppDimens.sm),
      ),
    );
  }

  static Color _getColor(BuildContext context, {required bool danger}) {
    return danger ? context.colors.error : context.colors.textButton;
  }
}
