import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/presentation/widgets/toggles/toggle.dart';

class ToggleTile extends StatelessWidget {
  const ToggleTile({
    required this.text,
    required this.value,
    required this.onTap,
    super.key,
  });

  final String text;
  final bool value;
  final ValueChanged<bool> onTap;

  @override
  Widget build(BuildContext context) {
    final isEnabled = ValueNotifier(value);

    return Container(
      width: double.infinity,
      height: AppDimens.buttonLg,
      padding: const EdgeInsets.all(
        AppDimens.md,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          AppDimens.radiusLg,
        ),
        color: context.colors.surface,
        boxShadow: context.shadows.sm,
      ),
      child: Row(
        children: [
          Text(text).textStyle(
            context.textTheme.bodyMd.medium,
            color: context.colors.textPrimary,
          ),
          const Spacer(),
          ValueListenableBuilder(
            valueListenable: isEnabled,
            builder: (context, value, child) {
              return Toggle(
                value: value,
                onChanged: (value) {
                  isEnabled.value = value;
                  onTap(value);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
