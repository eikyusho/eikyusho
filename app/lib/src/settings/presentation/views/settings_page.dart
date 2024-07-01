import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/src/settings/presentation/widgets/widgets.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPaddingWithAppBar;

    return Scaffold(
      appBar: MainAppBar(
        showLogo: true,
        actionIcon: Assets.icons.questionBold,
        actionButton: () {},
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.only(
          top: padding.top + AppDimens.$2xl,
          bottom: padding.bottom + AppDimens.$2xl,
          left: AppDimens.defaultHorizontalPadding,
          right: AppDimens.defaultHorizontalPadding,
        ),
        children: [
          SettingsCard(
            icon: Assets.icons.paletteBold,
            label: Text(context.translate.settings_title_profile),
            onTap: () => context.router.push(const ProfileRoute()),
          ),
          ...buildDivider(),
          BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final placeholder = state.themeMode == ThemeMode.system
                  ? context.translate.settings_placeholder_system_theme
                  : state.themeMode == ThemeMode.light
                      ? context.translate.settings_placeholder_light_theme
                      : context.translate.settings_placeholder_dark_theme;

              return SettingsCard(
                icon: Assets.icons.paletteBold,
                placeholder: placeholder,
                label: Text(context.translate.settings_title_appearance),
                onTap: () => {
                  context.showBottomSheet(const SelectThemeBottomSheet()),
                },
              );
            },
          ),
          ...buildDivider(),
          ...gapView(
            AppDimens.md,
            children: [
              SettingsCard(
                icon: Assets.icons.wrenchBold,
                label: Text(context.translate.settings_title_preferences),
              ),
              SettingsCard(
                icon: Assets.icons.bellBold,
                label: Text(context.translate.settings_title_notifications),
              ),
              SettingsCard(
                icon: Assets.icons.shieldCheckBold,
                label: Text(context.translate.settings_title_security),
              ),
              SettingsCard(
                icon: Assets.icons.cloudCheckBold,
                label: Text(context.translate.settings_title_backup_restore),
              ),
            ],
            isVertical: true,
          ),
          ...buildDivider(),
          SettingsCard(
            icon: Assets.icons.infoBold,
            label: Text(context.translate.settings_title_about),
          ),
        ],
      ),
    );
  }

  List<Widget> buildDivider() {
    return [
      const VSpace(AppDimens.lg),
      const Separator.horizontal(size: double.infinity),
      const VSpace(AppDimens.lg),
    ];
  }
}
