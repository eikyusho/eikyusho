import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:eikyusho_extensions/extensions.dart';
import 'package:resources/resources.dart';

import 'package:app/common/common.dart';
import 'package:app/src/browse/data/data.dart';

class ExtensionIcon extends StatelessWidget {
  const ExtensionIcon({
    required this.extension,
    required this.imageSize,
    this.shadows = false,
    super.key,
  });

  final AvailableExtension extension;
  final double imageSize;
  final bool shadows;

  @override
  Widget build(BuildContext context) {
    final pixelRatio = context.mediaQuery.devicePixelRatio;

    final density = switch (pixelRatio) {
      <= 1.5 => PixelDensity.x1,
      <= 2.5 => PixelDensity.x2,
      _ => PixelDensity.x3,
    };

    return Container(
      height: imageSize,
      width: imageSize,
      decoration: BoxDecoration(
        boxShadow: shadows ? context.shadows.sm : null,
      ),
      child: FutureBuilder<ImageProvider>(
        future: getIconLocation(density, extension),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }

          if (snapshot.hasData) {
            return Image(
              width: imageSize,
              height: imageSize,
              image: snapshot.requireData,
              loadingBuilder: (_, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const Loading();
              },
              errorBuilder: (_, __, ___) {
                return buildErrorIcon(context);
              },
            );
          }

          return buildErrorIcon(context);
        },
      ),
    );
  }

  Widget buildErrorIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.sm),
      child: Assets.icons.warningCircleBold.svg(
        colorFilter: ColorFilter.mode(
          context.colors.error,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
