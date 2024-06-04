part of 'widget.dart';

@immutable
final class _Styles {
  const _Styles._();

  static const width = AppDimens.buttonMd;
  static const height = AppDimens.buttonMd;
  static const iconSize = AppDimens.iconMd;
  static const borderRadius = AppDimens.radiusMd;
  static const alignment = Alignment.center;
  static const blendMode = AppMisc.blendMode;

  static Color iconColor(BuildContext context) => context.colors.primaryText;

  static Color backgroundColor(BuildContext context) => context.colors.surface;
}
