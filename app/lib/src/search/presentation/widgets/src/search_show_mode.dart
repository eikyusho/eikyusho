import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/search/presentation/cubits/cubits.dart';

class SearchShowMode extends StatelessWidget {
  const SearchShowMode({super.key});

  @override
  Widget build(BuildContext context) {
    const iconSize = AppDimens.iconLg;
    final selectedColor = context.colors.primary;
    final unselectedColor = context.colors.textSecondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(context.translate.label_show_mode).textStyle(
          context.textTheme.bodySm.medium,
          color: context.colors.textSubdued,
        ),
        ValueListenableBuilder(
          valueListenable: context.read<SearchCubit>().showMode,
          builder: (context, showMode, _) {
            final isGrid = showMode == ShowMode.grid;

            return Row(
              children: [
                AppIconButton(
                  Assets.icons.squaresFourBold,
                  iconColor: isGrid ? selectedColor : unselectedColor,
                  iconSize: iconSize,
                  size: iconSize,
                  color: AppColors.transparent,
                  onPressed: () {
                    context.read<SearchCubit>().changeShowModeToGrid();
                  },
                ),
                const SizedBox(width: AppDimens.xs),
                AppIconButton(
                  Assets.icons.rowsBold,
                  iconColor: isGrid ? unselectedColor : selectedColor,
                  iconSize: iconSize,
                  size: iconSize,
                  color: AppColors.transparent,
                  onPressed: () {
                    context.read<SearchCubit>().changeShowModeToList();
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
