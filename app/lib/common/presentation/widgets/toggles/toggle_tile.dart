import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/presentation/widgets/toggles/toggle.dart';

class ToggleTile extends StatefulWidget {
  const ToggleTile({
    required this.text,
    required this.onTap,
    super.key,
  });

  final String text;
  final VoidCallback onTap;

  @override
  State<ToggleTile> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleTile> {
  bool isEnable = false;

  @override
  Widget build(BuildContext context) {
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
          Text(widget.text).textStyle(
            context.textTheme.bodyMd.medium,
            color: context.colors.textPrimary,
          ),
          const Spacer(),
          Toggle(value: false, onChanged: (value) {}),
        ],
      ),
    );
  }
}
