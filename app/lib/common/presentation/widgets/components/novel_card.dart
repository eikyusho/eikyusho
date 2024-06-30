import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/common.dart';
import 'package:app/common/presentation/presentation.dart';
import 'package:app/src/browse/data/data.dart';

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
        Expanded(
          child: CardCover(
            cover: cover,
            width: double.infinity,
            height: double.infinity,
            extension: extension,
          ),
        ),
        const VSpace(AppDimens.xs),
        CardText(text: title, maxLines: 2).textStyle(
          context.textTheme.bodySm.medium,
          color: context.colors.textPrimary,
        ),
      ],
    );
  }
}

class NovelWideCard extends StatelessWidget {
  const NovelWideCard({
    required this.title,
    required this.cover,
    this.extension,
    this.author,
    super.key,
  });

  final String title;
  final String? author;
  final AvailableExtension? extension;
  final ImageProvider cover;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CardCover(
          cover: cover,
          width: 66,
          height: 104,
          extension: extension,
        ),
        const HSpace(AppDimens.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardText(text: title, maxLines: 2).textStyle(
                context.textTheme.bodyMd.medium,
                color: context.colors.textPrimary,
              ),
              CardText(text: author ?? '', maxLines: 1).textStyle(
                context.textTheme.bodySm.regular,
                color: context.colors.textSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

@protected
class CardCover extends StatelessWidget {
  const CardCover({
    required this.cover,
    required this.width,
    required this.height,
    required this.extension,
    super.key,
  });

  final ImageProvider cover;
  final AvailableExtension? extension;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            width: width,
            height: height,
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
    );
  }
}

@protected
class CardText extends StatelessWidget {
  const CardText({
    required this.text,
    required this.maxLines,
    super.key,
  });

  final String text;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 0,
      child: SizedBox(
        child: Text(
          '$text\n',
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
