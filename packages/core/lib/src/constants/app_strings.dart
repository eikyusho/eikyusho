final class AppStrings {
  const AppStrings._();

  // rename to pageTitleName
  static String pageDiscoverTitle = 'Discover';
  static String pageLibraryTitle = 'Library';
  static String pageSearchTitle = 'Search';
  static String pageBrowseTitle = 'Browse';
  static String pageSettingsTitle = 'Settings';
  static String pageExtensionsTitle = 'Extensions';

  // Discover rename to sectionTitleMostPopular
  static String discoverListMostPopularTitle = 'Most Popular';
  static String discoverListRecentlyUpdatedTitle = 'Recently Updated';

  // Section Title
  static String sectionTitlePendingUpdates = 'Pending Updates';
  static String sectionTitleAvailableExtensions = 'Available Extensions';
  static String sectionTitleLastUsed = 'Last Used';
  static String sectionTitleChapters = 'Chapters';

  /// Settings Options Titles
  static String settingsOptionsTitleProfile = 'Profile';
  static String settingsOptionsTitleAppearance = 'Appearance';
  static String settingsOptionsTitlePreferences = 'Preferences';
  static String settingsOptionsTitleNotifications = 'Notifications';
  static String settingsOptionsTitleSecurity = 'Security';
  static String settingsOptionsTitleBackupAndRestore = 'Backup & Restore';
  static String settingsOptionsTitleAbout = 'About';

  static String settingsOptionsPlaceholderSystemTheme = 'System';
  static String settingsOptionsPlaceholderDarkTheme = 'Dark';
  static String settingsOptionsPlaceholderLightTheme = 'Light';

  /// Buttons
  static String buttonClose = 'Close';
  static String buttonUninstallExtension = 'Uninstall Extension';
  static String buttonCancel = 'Cancel';
  static String buttonConfirm = 'Confirm';
  static String buttonSelectSource = 'Select Source';
  static String buttonWebView = 'WebView';
  static String buttonNextChapter = 'Next Chapter';

  /// Label
  static String labelVersion = 'Version';
  static String labelLanguage = 'Language';
  static String labelChapters = 'Chapters';
  static String labelStatus = 'Status';
  static String labelViews = 'Views';

  /// Meta
  static String metaDisabled = 'Disabled';

  /// Toggle
  static String toggleActiveExtension = 'Active';
  static String toggleDiscoverExtension = 'Discover';
  static String toggleShowDisabled = 'Show Disabled';

  /// Dialog
  static String dialogUninstallExtension = 'Uninstall Extension';
  static String dialogDescriptionUninstallExtension =
      'Are you sure you want to uninstall this extension?';

  /// Empty State
  static String emptyStateNoSources = 'No sources available';
  static String emptyStateDescriptionNoSources =
      'You have not added any sources yet.';
  static String emptyStateNoSelectedSource = 'No source selected';
  static String emptyStateDescriptionNoSelectedSource =
      'Select a source to see the discover page.';

  /// Empty State Error
  static String emptyStateError = 'Something went wrong';
  static String emptyStateDescriptionError =
      'An error occurred while loading the page.';

  static String emptyStateDescriptionErrorSources =
      'An error occurred while loading the sources.';

  static String emptyStateErrorLoading = 'Loading error';
  static String emptyStateDescriptionErrorLoading =
      "Couldn't establish a connection.";

  static String emptyStateErrorLoadingNovel = "Couldn't load the novel list.";

  /// Tips
  static String tipDoubleTapDiscover =
      'Double tap "Discover" to see the WebView.';
  static String tipOpenWebView = 'Open WebView to check the content.';

  /// Snackbars
  static String extensionInstalled = 'Extension installed';
  static String extensionUpdated = 'Extension updated';
  static String failedToInstall = 'Failed to install';
  static String failedToUpdate = 'Failed to update';
}
