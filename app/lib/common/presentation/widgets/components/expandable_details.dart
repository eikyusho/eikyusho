import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class ExpandableDetails extends StatelessWidget {
  const ExpandableDetails({
    required this.description,
    required this.genres,
    super.key,
  });

  final String description;
  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    final expanded = ValueNotifier<bool>(false);

    return ValueListenableBuilder(
      valueListenable: expanded,
      builder: (context, isExpanded, child) {
        final genres = upperCaseGenres();
        final limitedGenres = genres.take(3);

        return Column(
          children: [
            AnimatedCrossFade(
              firstChild: Text(description),
              secondChild: Text(
                description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: AppMisc.normalDuration,
            ).textStyle(
              context.textTheme.bodySm.regular,
              color: context.colors.textSecondary,
            ),
            const VSpace(AppDimens.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    (isExpanded ? genres : limitedGenres).join(' '),
                  ).textStyle(
                    context.textTheme.bodyXs.bold,
                    color: context.colors.textAuxiliary,
                  ),
                ),
                AppIconButton(
                  Assets.icons.caretDownBold,
                  size: AppDimens.buttonXs,
                  onPressed: () {
                    expanded.value = !isExpanded;
                  },
                  child: AnimatedSwitcher(
                    duration: AppMisc.normalDuration,
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return RotationTransition(turns: animation, child: child);
                    },
                    child: isExpanded
                        ? buildIcon(Assets.icons.caretUpBold, context)
                        : buildIcon(Assets.icons.caretDownBold, context),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  List<String> upperCaseGenres() {
    return genres.map((tag) => '#${tag.toUpperCase()}').toList();
  }

  Widget buildIcon(SvgGenImage icon, BuildContext context) {
    return icon.svg(
      width: AppDimens.iconXs,
      height: AppDimens.iconXs,
      colorFilter: svgColor(
        context.colors.textPrimary,
      ),
    );
  }
}
