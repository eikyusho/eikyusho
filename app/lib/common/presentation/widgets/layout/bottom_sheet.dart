import 'package:flutter/material.dart';

import 'package:core/core.dart';

import 'package:app/common/presentation/presentation.dart';

enum AppBottomSheetType { singleAction, doubleAction }

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    required this.children,
    this.type = AppBottomSheetType.singleAction,
    this.primaryText,
    this.onClose,
    this.onPrimaryAction,
    super.key,
  });

  final AppBottomSheetType type;
  final List<Widget> children;

  /// This callback is called before the bottom sheet is closed.
  final VoidCallback? onClose;

  /// This is only used when [type] is [AppBottomSheetType.doubleAction].
  /// This also closes the bottom sheet.
  final VoidCallback? onPrimaryAction;
  final String? primaryText;

  @override
  Widget build(BuildContext context) {
    assert(
      !(type == AppBottomSheetType.doubleAction && onPrimaryAction == null),
      'onPrimaryAction must not be null when type is doubleAction',
    );
    assert(
      !(type == AppBottomSheetType.doubleAction && primaryText == null),
      'primaryText must not be null when type is doubleAction',
    );
    assert(
      !(type == AppBottomSheetType.singleAction && onPrimaryAction != null),
      'onPrimaryAction must be null when type is singleAction',
    );

    return Container(
      padding: const EdgeInsets.only(
        right: AppDimens.defaultHorizontalPadding,
        left: AppDimens.defaultHorizontalPadding,
        top: AppDimens.lg,
        bottom: AppDimens.$2xl,
      ),
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimens.radius2Xl),
          topRight: Radius.circular(AppDimens.radius2Xl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: context.colors.borderInverse,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const VSpace(AppDimens.$2xl),
          ...children,
          const VSpace(AppDimens.lg),
          Row(
            children: [
              if (type == AppBottomSheetType.doubleAction)
                Button(
                  type: ButtonType.secondary,
                  text: AppStrings.buttonClose,
                  onTap: () {
                    onClose?.call();
                    Navigator.of(context).pop();
                  },
                ).expanded(),
              Button(
                text: primaryText ?? AppStrings.buttonClose,
                onTap: () {
                  if (type == AppBottomSheetType.singleAction) {
                    onClose?.call();
                  } else {
                    onPrimaryAction?.call();
                  }
                  Navigator.of(context).pop();
                },
              ).expanded(),
            ],
          ).gap(AppDimens.sm),
        ],
      ),
    );
  }
}
