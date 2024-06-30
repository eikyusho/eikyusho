import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';

class WebViewControls extends StatelessWidget {
  const WebViewControls({
    required this.onBack,
    required this.onForward,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onForward;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.bottomNavigationBarHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.defaultHorizontalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppIconButton(
            Assets.icons.caretLeftBold,
            onPressed: onBack,
          ),
          AppIconButton(
            Assets.icons.caretRightBold,
            onPressed: onForward,
          ),
          AppIconButton(
            Assets.icons.shareFatBold,
          ),
          AppIconButton(
            Assets.icons.compass,
          ),
        ],
      ),
    );
  }
}
