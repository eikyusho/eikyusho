import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/core.dart';

import 'package:app/common/common.dart';
import 'package:app/fake/novels.dart';

class DiscoverSpotlight extends StatelessWidget {
  const DiscoverSpotlight({super.key});

  @override
  Widget build(BuildContext context) {
    final novels = $TempData().getListOne();

    return CarouselSlider(
      options: CarouselOptions(
        height: context.responsiveHeight(0.5, absoluteHeight: 380),
        enlargeCenterPage: true,
        viewportFraction: 0.65,
        clipBehavior: Clip.none,
      ),
      items: novels
          .map((novel) => _SpotlightItem(cover: novel.cover))
          .toList()
          .limit(5),
    );
  }
}

class _SpotlightItem extends StatelessWidget {
  const _SpotlightItem({required this.cover});

  final String cover;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: context.shadows.lg,
      ),
      child: ClickableElement(
        borderRadius: AppDimens.radiusLg,
        animation: ClickableElementAnimation.shrink,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(cover),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
