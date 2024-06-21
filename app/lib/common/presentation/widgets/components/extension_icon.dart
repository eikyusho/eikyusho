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
    super.key,
  });

  final AvailableExtension extension;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    final pixelRatio = context.mediaQuery.devicePixelRatio;

    final density = switch (pixelRatio) {
      <= 1.5 => PixelDensity.x1,
      <= 2.5 => PixelDensity.x2,
      _ => PixelDensity.x3,
    };

    return SizedBox(
      height: imageSize,
      width: imageSize,
      child: FutureBuilder<ImageProvider>(
        future: getIconLocation(density, extension),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }

          if (snapshot.hasData) {
            final isNetworkImage = snapshot.requireData is NetworkImage;

            return Image(
              width: imageSize,
              height: imageSize,
              image: snapshot.requireData,
              loadingBuilder: isNetworkImage
                  ? (_, __, ___) {
                      return const Loading();
                    }
                  : null,
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
