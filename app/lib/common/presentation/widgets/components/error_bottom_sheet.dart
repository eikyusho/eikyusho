import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/config/app.dart';
import 'package:app/src/discover/presentation/presentation.dart';

class ErrorBottomSheet extends StatelessWidget {
  const ErrorBottomSheet({
    required this.message,
    required this.description,
    required this.error,
    required this.url,
    super.key,
  });

  final String message;
  final String description;
  final Exception error;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      children: [
        Column(
          children: [
            Text(message).textStyle(
              context.textTheme.titleSm.black,
              color: context.colors.textPrimary,
              align: TextAlign.center,
            ),
            const VSpace(AppDimens.xs),
            Text(description).textStyle(
              context.textTheme.bodyMd.regular,
              color: context.colors.textSecondary,
              align: TextAlign.center,
            ),
            const VSpace(AppDimens.$3xl),
            InfoMessage(
              icon: Assets.icons.warningBold,
              message: error.toString(),
            ),
            const VSpace(AppDimens.$3xl),
            Row(
              children: [
                Expanded(
                  child: FatIconButton(
                    icon: Assets.icons.globeHemisphereWestBold,
                    text: context.translate.button_webview,
                    onTap: () {
                      if (url != null) {
                        context.read<DiscoverCubit>().openWebView(context);
                        return;
                      }

                      context.router.push(WebViewRoute(url: url!));
                    },
                  ),
                ),
                const HSpace(AppDimens.md),
                Expanded(
                  child: FatIconButton(
                    icon: Assets.icons.questionBold,
                    text: context.translate.button_help,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
