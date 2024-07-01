import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';

import 'package:app/common/common.dart';

class SelectThemeBottomSheet extends StatelessWidget {
  const SelectThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return AppBottomSheet(
          children: [
            ThemeOption(
              theme: ThemeMode.system,
              selectedTheme: state.themeMode,
            ),
            const VSpace(AppDimens.md),
            ThemeOption(
              theme: ThemeMode.light,
              selectedTheme: state.themeMode,
            ),
            const VSpace(AppDimens.md),
            ThemeOption(
              theme: ThemeMode.dark,
              selectedTheme: state.themeMode,
            ),
          ],
        );
      },
    );
  }
}

class ThemeOption extends StatelessWidget {
  const ThemeOption({
    required this.theme,
    required this.selectedTheme,
    super.key,
  });

  final ThemeMode theme;

  final ThemeMode selectedTheme;

  @override
  Widget build(BuildContext context) {
    final name = theme == ThemeMode.system
        ? context.translate.settings_placeholder_system_theme
        : theme == ThemeMode.light
            ? context.translate.settings_placeholder_light_theme
            : context.translate.settings_placeholder_dark_theme;

    return ClickableElement(
      onTap: () async {
        context.read<AppCubit>().setThemeMode(theme);
        if (context.mounted) Navigator.of(context).pop();
      },
      child: Container(
        height: AppDimens.buttonLg,
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.sm,
          horizontal: AppDimens.md,
        ),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        ),
        child: Row(
          children: [
            Text(name).textStyle(
              context.textTheme.bodyLg.medium,
              color: context.colors.textPrimary,
            ),
            const Spacer(),
            SizedBox(
              width: AppDimens.buttonXs,
              height: AppDimens.buttonXs,
              child: Radio(
                value: theme,
                groupValue: selectedTheme,
                onChanged: (_) {},
                activeColor: context.colors.primary,
                splashRadius: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
