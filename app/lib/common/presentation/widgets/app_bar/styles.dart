part of 'widget.dart';

@immutable
final class _Styles {
  const _Styles._();

  static const logoSize = AppDimens.logoHeight;
  static const blurSigma = AppMisc.blurFilter;
  static const blendMode = AppMisc.blendMode;
  static const height = AppDimens.appBarHeight;
  static const buttonsGap = AppDimens.md;
  static const alignment = Alignment.center;
  static const titleAlignment = TextAlign.center;
  static const titleLabel = '${AppConstants.appName} Logo';
  static const mainAxisSize = MainAxisSize.min;
  
  static const padding = EdgeInsets.symmetric(
    horizontal: AppDimens.$2xl,
    vertical: AppDimens.md,
  );

  static final optionsIcon = Assets.icons.dotsThreeOutlineFill;
  static final notificationIcon = Assets.icons.bellBold;

  static TextStyle titleStyle(BuildContext context) =>
      context.textTheme.titleSm.bold;
  
  static Color logoColor(BuildContext context) => context.colors.textPrimary;
  static Color titleColor(BuildContext context) => context.colors.textPrimary;

  static Color backgroundColor(BuildContext context) =>
      context.colors.background.withOpacity(AppMisc.blurBgOpacity);
}
