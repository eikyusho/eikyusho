import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/src/reader/presentation/cubits/cubits.dart';

class ReaderSettings extends StatelessWidget {
  const ReaderSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: ReaderChapterSlider(),
        ),
        const VSpace(AppDimens.md),
        BlocBuilder<ReaderCubit, ReaderState>(
          builder: (context, state) {
            if (state is! ReaderLoaded) return const Loading();

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReaderSettingsButton(
                  icon: Assets.icons.listBold,
                  text: context.translate.label_chapters,
                  onPressed: () {},
                ).expanded(),
                const HSpace(AppDimens.md),
                ReaderSettingsButton(
                  icon: Assets.icons.infoBold,
                  text: context.translate.button_about,
                  onPressed: () {
                    context.router.navigate(
                      NovelRoute(novel: state.chapter.novel),
                    );
                  },
                ).expanded(),
              ],
            );
          },
        ),
        const VSpace(AppDimens.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReaderSettingsButton(
              icon: Assets.icons.headphonesBold,
              onPressed: () {},
            ),
            ReaderSettingsButton(
              icon: Assets.icons.translateBold,
              onPressed: () {},
            ),
            ReaderSettingsButton(
              icon: Assets.icons.globeHemisphereWestBold,
              onPressed: () {},
            ),
            ReaderSettingsButton(
              icon: Assets.icons.stackBold,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class ReaderSettingsButton extends StatelessWidget {
  const ReaderSettingsButton({
    required this.icon,
    required this.onPressed,
    this.text,
    super.key,
  });

  final SvgGenImage icon;
  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final width = text == null ? 76.0 : double.infinity;
    const height = 76.0;

    return SizedBox(
      width: width,
      child: ClickableElement(
        animation: ClickableElementAnimation.shrink,
        onTap: onPressed,
        child: Container(
          width: text == null ? 76 : double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            boxShadow: context.shadows.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon.svg(
                colorFilter: svgColor(context.colors.textPrimary),
                height: AppDimens.iconXl,
                width: AppDimens.iconXl,
              ),
              if (text != null) ...[
                const HSpace(AppDimens.sm),
                Text(text!).textStyle(
                  context.textTheme.bodyLg.medium,
                  color: context.colors.textPrimary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ReaderChapterSlider extends StatelessWidget {
  const ReaderChapterSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.md,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        boxShadow: context.shadows.sm,
      ),
      child: BlocBuilder<ReaderCubit, ReaderState>(
        builder: (context, state) {
          if (state is! ReaderLoaded) return const Loading();

          final number = state.chapter.number;
          final title = state.chapter.title;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Ch $number: $title').textStyle(
                context.textTheme.bodyMd.medium,
                color: context.colors.textAuxiliary,
              ),
              const VSpace(AppDimens.sm),
              buildSlider(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget buildSlider(BuildContext context, ReaderLoaded state) {
    return Row(
      children: gapView(
        AppDimens.xs,
        children: [
          AppIconButton(
            Assets.icons.caretLeftBold,
            onPressed: () {
              context.read<ReaderCubit>().pageController.previousPage(
                    duration: AppMisc.normalDuration,
                    curve: Curves.easeInOut,
                  );
            },
            size: AppDimens.buttonXs,
            color: AppColors.transparent,
          ),
          Expanded(
            child: SizedBox(
              height: AppDimens.buttonXs,
              width: double.infinity,
              child: SliderTheme(
                data: SliderThemeData(
                  overlayShape: SliderComponentShape.noOverlay,
                  trackShape: EdgeToEdgeTrackShape(),
                ),
                child: Slider(
                  value: context.read<ReaderCubit>().currentPage.toDouble(),
                  max: state.chapters.length.toDouble(),
                  onChanged: (value) {
                    context
                        .read<ReaderCubit>()
                        .pageController
                        .jumpToPage(value.toInt());
                  },
                ),
              ),
            ),
          ),
          AppIconButton(
            Assets.icons.caretRightBold,
            onPressed: () {
              context.read<ReaderCubit>().pageController.nextPage(
                    duration: AppMisc.normalDuration,
                    curve: Curves.easeInOut,
                  );
            },
            size: AppDimens.buttonXs,
            color: AppColors.transparent,
          ),
        ],
      ),
    );
  }
}

class EdgeToEdgeTrackShape extends RoundedRectSliderTrackShape {
  // Override getPreferredRect to adjust the track's dimensions
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight ?? 2.0;
    final trackWidth = parentBox.size.width;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(offset.dx, trackTop, trackWidth, trackHeight);
  }
}
