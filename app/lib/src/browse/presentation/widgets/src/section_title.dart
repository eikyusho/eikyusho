import 'package:flutter/material.dart';

import 'package:core/core.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(
        left: AppDimens.defaultHorizontalPadding,
        right: AppDimens.defaultHorizontalPadding,
        bottom: AppDimens.sm,
      ),
      sliver: SliverToBoxAdapter(
        child: Text(title).textStyle(
          context.textTheme.bodyMd.regular,
          color: context.colors.textSubdued,
        ),
      ),
    );
  }
}
