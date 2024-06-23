import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/discover/presentation/cubits/cubits.dart';

class DiscoverListHeader extends StatelessWidget {
  const DiscoverListHeader({required this.title, this.onPressed, super.key});

  final Text title;
  final void Function(DiscoverContentInitial)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        title.textStyle(
          context.textTheme.titleSm.bold,
          color: context.colors.textPrimary,
        ),
        AppIconButton(
          Assets.icons.caretRightBold,
          iconColor: context.colors.primary,
          onPressed: () {
            final state = context.read<DiscoverContentCubit>().state
                as DiscoverContentInitial;

            onPressed?.call(state);
          },
        ),
      ],
    ).px(AppDimens.defaultHorizontalPadding).pb(AppDimens.lg);
  }
}
