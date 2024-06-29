import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/data/data.dart';

class NovelGrid extends StatelessWidget {
  const NovelGrid({required this.novels, required this.builder, super.key});

  final List<Novel> novels;
  final Widget Function(BuildContext, Novel) builder;

  @override
  Widget build(BuildContext context) {
    final padding = context.screenPadding;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: .55,
        crossAxisSpacing: AppDimens.sm,
        mainAxisSpacing: AppDimens.md,
      ),
      padding: EdgeInsets.only(
        top: padding.top + AppDimens.$2xl,
        bottom: padding.bottom + AppDimens.$2xl,
        left: AppDimens.defaultHorizontalPadding,
        right: AppDimens.defaultHorizontalPadding,
      ),
      itemBuilder: (context, index) {
        final novel = novels[index];

        return builder(context, novel);
      },
      itemCount: novels.length,
    );
  }
}