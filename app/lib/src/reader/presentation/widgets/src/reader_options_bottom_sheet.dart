import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/reader/presentation/widgets/src/reader_settings.dart';

class ReaderOptionsBottomSheet extends StatelessWidget {
  const ReaderOptionsBottomSheet(this._pageController, {super.key});

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: AppBottomSheet(
        type: AppBottomSheetType.noAction,
        children: [
          SizedBox(
            height: 252,
            child: TabBarView(
              children: [
                ReaderSettings(
                  _pageController,
                ),
                const Text('Settings'),
                const Text('About'),
              ],
            ),
          ),
          const VSpace(AppDimens.$4xl),
          const ReaderOptionsBottomSheetTabs(),
        ],
      ),
    );
  }
}

class ReaderOptionsBottomSheetTabs extends StatelessWidget {
  const ReaderOptionsBottomSheetTabs({super.key});

  @override
  Widget build(BuildContext context) {
    const iconSIze = AppDimens.iconLg;
    final controller = DefaultTabController.of(context);

    final selected = ValueNotifier(controller.index);

    controller.addListener(() {
      selected.value = controller.index;
    });

    return ValueListenableBuilder(
      valueListenable: selected,
      builder: (context, selected, _) {
        final selectedColor = context.colors.textPrimary;
        final unselectedColor = context.colors.textAuxiliary;

        return Container(
          height: 48,
          padding: const EdgeInsets.all(AppDimens.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIconButton(
                Assets.icons.nutFill,
                onPressed: () => controller.animateTo(0),
                iconSize: iconSIze,
                iconColor: selected == 0 ? selectedColor : unselectedColor,
                color: AppColors.transparent,
              ),
              AppIconButton(
                Assets.icons.sunBold,
                onPressed: () => controller.animateTo(1),
                iconSize: iconSIze,
                iconColor: selected == 1 ? selectedColor : unselectedColor,
                color: AppColors.transparent,
              ),
              AppIconButton(
                Assets.icons.textAaBold,
                onPressed: () => controller.animateTo(2),
                iconSize: iconSIze,
                iconColor: selected == 2 ? selectedColor : unselectedColor,
                color: AppColors.transparent,
              ),
            ],
          ),
        );
      },
    );
  }
}
