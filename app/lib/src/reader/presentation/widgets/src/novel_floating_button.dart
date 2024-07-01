import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/library/presentation/presentation.dart';
import 'package:app/src/reader/presentation/cubits/cubits.dart';

class NovelFloatingButton extends StatelessWidget {
  const NovelFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NovelCubit, NovelState>(
      builder: (context, state) {
        if (state is! NovelLoaded) return const SizedBox();
        if (state.isLoading) return const SizedBox();

        return buildButton(context, state);
      },
    );
  }

  Widget buildButton(BuildContext context, NovelLoaded state) {
    Future<void> addToLibrary() async {
      await context
          .read<NovelCubit>()
          .addToLibrary(state.novel, state.chapters);
      if (context.mounted) await context.read<LibraryCubit>().loadLibrary();
    }

    Future<void> removeFromLibrary() async {
      await context.read<NovelCubit>().removeFromLibrary(state.novel);
      if (context.mounted) await context.read<LibraryCubit>().loadLibrary();
    }

    return BlurredContainer(
      blur: AppMisc.blurFilter,
      child: Container(
        height: AppDimens.bottomNavigationBarHeight,
        padding: const EdgeInsets.all(AppDimens.sm),
        decoration: BoxDecoration(
          color: getBlurredBgColor(
            context,
            color: context.colors.backgroundSecondary,
          ),
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          boxShadow: context.shadows.md,
        ),
        child: Row(
          children: [
            Flexible(
              child: Button(
                text: context.translate.button_read,
                onTap: () {},
              ),
            ),
            const HSpace(AppDimens.sm),
            AppIconButton(
              !state.isLocal ? Assets.icons.heartBold : Assets.icons.heartFill,
              size: AppDimens.buttonLg,
              iconSize: AppDimens.iconLg,
              color: context.colors.background,
              onPressed: !state.isLocal ? addToLibrary : removeFromLibrary,
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 1);
  }
}
