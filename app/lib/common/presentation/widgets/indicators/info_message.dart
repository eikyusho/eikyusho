import 'package:flutter/cupertino.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

class InfoMessage extends StatelessWidget {
  const InfoMessage({required this.icon, required this.message, super.key});

  final SvgGenImage icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.defaultHorizontalPadding,
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.svg(
              width: AppDimens.iconMd,
              height: AppDimens.iconMd,
              colorFilter: svgColor(context.colors.textSecondary),
            ),
            const HSpace(AppDimens.sm),
            Flexible(
              child: Text(
                message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ).textStyle(
                context.textTheme.bodySm.regular,
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
