import 'package:flutter/material.dart';

import 'package:core/core.dart';

class NovelCard extends StatelessWidget {
  const NovelCard({required this.cover, required this.title, super.key});

  final ImageProvider cover;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            color: context.colors.backgroundSecondary,
            boxShadow: context.shadows.md,
          ),
          child: Image(
            image: cover,
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
        ).expanded(),
        const VSpace(AppDimens.xs),
        Flexible(
          flex: 0,
          child: SizedBox(
            child: Text('$title\n', maxLines: 2).textStyle(
              context.textTheme.bodySm.medium.apply(
                overflow: TextOverflow.ellipsis,
              ),
              color: context.colors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
