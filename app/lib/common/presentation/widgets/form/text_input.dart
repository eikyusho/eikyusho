import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    required this.placeholder,
    required this.prefixIcon,
    super.key,
  });

  final String placeholder;
  final SvgGenImage prefixIcon;

  @override
  Widget build(BuildContext context) {
    const hasFocus = false;

    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.md),
      decoration: BoxDecoration(
        color: context.colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(
          color: hasFocus ? context.colors.primary : context.colors.border,
        ),
      ),
      child: Row(
        children: [
          prefixIcon.svg(
            width: AppDimens.iconLg,
            height: AppDimens.iconLg,
            colorFilter: svgColor(context.colors.textAuxiliary),
          ),
          const HSpace(AppDimens.sm),
          Expanded(
            child: TextField(
              style: context.textTheme.bodyMd.medium.apply(
                color: context.colors.textPrimary,
              ),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.transparent,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintStyle: context.textTheme.bodyMd.regular.apply(
                  color: context.colors.textAuxiliary,
                ),
                contentPadding: EdgeInsets.zero,
                hintText: 'Search',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
