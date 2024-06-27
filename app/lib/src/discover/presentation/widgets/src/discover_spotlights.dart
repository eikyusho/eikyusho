import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/common/common.dart';
import 'package:app/src/discover/presentation/cubits/cubits.dart';

class DiscoverSpotlights extends StatelessWidget {
  const DiscoverSpotlights({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.responsiveHeight(
      0.5,
      absoluteHeight: 380,
    );

    return BlocBuilder<DiscoverContentCubit, DiscoverContentState>(
      builder: (context, state) {
        state as DiscoverContentInitial;

        if (state.spotlightsLoading) {
          return SizedBox(
            height: height,
            child: const Loading(),
          );
        }

        return CarouselSlider(
            options: CarouselOptions(
              height: height,
              enlargeCenterPage: true,
              viewportFraction: 0.65,
              clipBehavior: Clip.none,
            ),
            items: state.spotlights
                .map((novel) => _SpotlightItem(novel: novel))
                .take(5)
                .toList());
      },
    ).px(AppDimens.defaultHorizontalPadding);
  }
}

class _SpotlightItem extends StatelessWidget {
  const _SpotlightItem({required this.novel});

  final Novel novel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: context.shadows.lg,
      ),
      child: ClickableElement(
        borderRadius: AppDimens.radiusLg,
        animation: ClickableElementAnimation.shrink,
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(novel.cover),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
