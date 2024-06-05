part of 'navigation_bar.dart';

@immutable
final class _Styles {
  const _Styles._();

  static const iconSize = AppDimens.iconXl;
  static const blurSigma = AppMisc.blurFilter;
  static const height = AppDimens.bottomNavigationBarHeight;
  static const itemsGap = AppDimens.xs;
  static const blendMode = AppMisc.blendMode;
  static const navItemAlignment = MainAxisAlignment.center;
  static const clickAnimation = ClickableElementAnimation.none;
  static const padding = EdgeInsets.symmetric(
    horizontal: AppDimens.xl,
  );

  static final discoverIcon = Assets.icons.house;
  static final libraryIcon = Assets.icons.books;
  static final searchIcon = Assets.icons.magnifyingGlass;
  static final browseIcon = Assets.icons.compass;
  static final settingsIcon = Assets.icons.gear;

  static Color currentColor(BuildContext context, {required bool isSelected}) {
    return isSelected ? context.colors.primary : context.colors.textSecondary;
  }

  static Color backgroundColor(BuildContext context) {
    return context.colors.background.withOpacity(AppMisc.blurBgOpacity);
  }

  static TextStyle labelTextStyle(BuildContext context) {
    return context.textTheme.bodyXs.medium;
  }
}
