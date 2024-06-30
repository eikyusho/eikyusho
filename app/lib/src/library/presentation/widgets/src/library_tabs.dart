import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/common.dart';

class LibraryTabs extends MainAppBarBottom {
  const LibraryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getBlurredBgColor(context),
      padding: const EdgeInsets.only(
        top: AppDimens.$2xl,
        left: AppDimens.defaultHorizontalPadding,
        right: AppDimens.defaultHorizontalPadding,
        bottom: AppDimens.sm,
      ),
      child: Container(
        height: tabBarHeight,
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(AppDimens.radius2Xl),
        ),
        child: TabBar(
          dividerHeight: 0,
          indicator: BoxDecoration(
            color: context.colors.primary,
            borderRadius: BorderRadius.circular(AppDimens.radiusXl),
          ),
          padding: const EdgeInsets.all(AppDimens.sm),
          labelColor: context.colors.textButton,
          unselectedLabelColor: context.colors.textSecondary,
          labelStyle: context.textTheme.bodyMd.bold,
          unselectedLabelStyle: context.textTheme.bodyMd,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          tabs: [
            Tab(text: AppStrings.sectionTitleReading),
            Tab(text: AppStrings.sectionTitleCompleted),
            Tab(text: AppStrings.sectionTitleCollections),
          ],
        ),
      ),
    );
  }

  static const double tabBarHeight = 48;

  @override
  double get height => tabBarHeight + AppDimens.$2xl + AppDimens.sm;
}
