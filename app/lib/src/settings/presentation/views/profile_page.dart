import 'package:flutter/material.dart';

import 'package:auto_route/annotations.dart';
import 'package:core/core.dart';
import 'package:localization/localization.dart';

import 'package:app/common/common.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPaddingWithAppBar;

    return Scaffold(
      appBar: MainAppBar(
        title: Text(context.translate.settings_title_profile),
      ),
      body: Column(
        children: [
          const ProfileCard(),
          const VSpace(AppDimens.$4xl),
          Button(
            text: context.translate.button_random,
            onTap: () {},
          ),
          const VSpace(AppDimens.$4xl),
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

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.md),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Column(
        children: [],
      ),
    );
  }
}

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
