import 'package:app/common/common.dart';
import 'package:app/src/browse/data/data.dart';
import 'package:flutter/material.dart';

import 'package:core/core.dart';

class NovelCard extends StatelessWidget {
  const NovelCard({
    required this.cover,
    required this.title,
    this.extension,
    super.key,
  });

  final ImageProvider cover;
  final String title;
  final AvailableExtension? extension;

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
          child: Stack(
            children: [
              Image(
                image: cover,
                width: double.maxFinite,
                height: double.maxFinite,
                fit: BoxFit.cover,
              ),
              if (extension != null)
                Positioned(
                  child: ExtensionIcon(
                    extension: extension!,
                    imageSize: AppDimens.iconLg,
                    shadows: true,
                  ),
                ),
            ],
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
