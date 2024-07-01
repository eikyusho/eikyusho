import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localization_en.dart';
import 'localization_pt.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'src/localization.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @page_title_discover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get page_title_discover;

  /// No description provided for @page_title_library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get page_title_library;

  /// No description provided for @page_title_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get page_title_search;

  /// No description provided for @page_title_browse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get page_title_browse;

  /// No description provided for @page_title_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get page_title_settings;

  /// No description provided for @page_title_extensions.
  ///
  /// In en, this message translates to:
  /// **'Extensions'**
  String get page_title_extensions;

  /// No description provided for @section_title_most_popular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get section_title_most_popular;

  /// No description provided for @section_title_recently_updated.
  ///
  /// In en, this message translates to:
  /// **'Recently Updated'**
  String get section_title_recently_updated;

  /// No description provided for @section_title_pending_updates.
  ///
  /// In en, this message translates to:
  /// **'Pending Updates'**
  String get section_title_pending_updates;

  /// No description provided for @section_title_available_extensions.
  ///
  /// In en, this message translates to:
  /// **'Available Extensions'**
  String get section_title_available_extensions;

  /// No description provided for @section_title_last_used.
  ///
  /// In en, this message translates to:
  /// **'Last Used'**
  String get section_title_last_used;

  /// No description provided for @section_title_chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get section_title_chapters;

  /// No description provided for @section_title_reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get section_title_reading;

  /// No description provided for @section_title_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get section_title_completed;

  /// No description provided for @section_title_collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get section_title_collections;

  /// No description provided for @settings_title_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settings_title_profile;

  /// No description provided for @settings_title_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_title_appearance;

  /// No description provided for @settings_title_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settings_title_preferences;

  /// No description provided for @settings_title_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settings_title_notifications;

  /// No description provided for @settings_title_security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get settings_title_security;

  /// No description provided for @settings_title_backup_restore.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get settings_title_backup_restore;

  /// No description provided for @settings_title_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_title_about;

  /// No description provided for @settings_placeholder_system_theme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settings_placeholder_system_theme;

  /// No description provided for @settings_placeholder_dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_placeholder_dark_theme;

  /// No description provided for @settings_placeholder_light_theme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_placeholder_light_theme;

  /// No description provided for @button_close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get button_close;

  /// No description provided for @button_uninstall_extension.
  ///
  /// In en, this message translates to:
  /// **'Uninstall Extension'**
  String get button_uninstall_extension;

  /// No description provided for @button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get button_cancel;

  /// No description provided for @button_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get button_confirm;

  /// No description provided for @button_select_source.
  ///
  /// In en, this message translates to:
  /// **'Select Source'**
  String get button_select_source;

  /// No description provided for @button_webview.
  ///
  /// In en, this message translates to:
  /// **'WebView'**
  String get button_webview;

  /// No description provided for @button_read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get button_read;

  /// No description provided for @button_continue_reading.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get button_continue_reading;

  /// No description provided for @label_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get label_version;

  /// No description provided for @label_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get label_language;

  /// No description provided for @label_chapters.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get label_chapters;

  /// No description provided for @label_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get label_status;

  /// No description provided for @label_views.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get label_views;

  /// No description provided for @label_show_mode.
  ///
  /// In en, this message translates to:
  /// **'Show in'**
  String get label_show_mode;

  /// No description provided for @hint_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get hint_search;

  /// No description provided for @hint_search_globally.
  ///
  /// In en, this message translates to:
  /// **'Search Globally'**
  String get hint_search_globally;

  /// No description provided for @hint_search_locally.
  ///
  /// In en, this message translates to:
  /// **'Search Locally'**
  String get hint_search_locally;

  /// No description provided for @meta_disabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get meta_disabled;

  /// No description provided for @toggle_active_extension.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get toggle_active_extension;

  /// No description provided for @toggle_discover_extension.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get toggle_discover_extension;

  /// No description provided for @toggle_show_disabled.
  ///
  /// In en, this message translates to:
  /// **'Show Disabled'**
  String get toggle_show_disabled;

  /// No description provided for @dialog_uninstall_extension.
  ///
  /// In en, this message translates to:
  /// **'Uninstall Extension'**
  String get dialog_uninstall_extension;

  /// No description provided for @dialog_description_uninstall_extension.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to uninstall this extension?'**
  String get dialog_description_uninstall_extension;

  /// No description provided for @empty_state_no_sources.
  ///
  /// In en, this message translates to:
  /// **'No sources available'**
  String get empty_state_no_sources;

  /// No description provided for @empty_state_description_no_sources.
  ///
  /// In en, this message translates to:
  /// **'You have not added any sources yet.'**
  String get empty_state_description_no_sources;

  /// No description provided for @empty_state_no_selected_source.
  ///
  /// In en, this message translates to:
  /// **'No source selected'**
  String get empty_state_no_selected_source;

  /// No description provided for @empty_state_description_no_selected_source.
  ///
  /// In en, this message translates to:
  /// **'Select a source to see the discover page.'**
  String get empty_state_description_no_selected_source;

  /// No description provided for @empty_state_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get empty_state_error;

  /// No description provided for @empty_state_description_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading the page.'**
  String get empty_state_description_error;

  /// No description provided for @empty_state_error_loading_sources.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading the sources.'**
  String get empty_state_error_loading_sources;

  /// No description provided for @empty_state_error_loading.
  ///
  /// In en, this message translates to:
  /// **'Loading error'**
  String get empty_state_error_loading;

  /// No description provided for @empty_state_description_error_loading.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t establish a connection.'**
  String get empty_state_description_error_loading;

  /// No description provided for @empty_state_error_loading_novel.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the novel list.'**
  String get empty_state_error_loading_novel;

  /// No description provided for @empty_state_collection.
  ///
  /// In en, this message translates to:
  /// **'No Collections'**
  String get empty_state_collection;

  /// No description provided for @empty_state_description_collection.
  ///
  /// In en, this message translates to:
  /// **'Create a collection to organize your novels.'**
  String get empty_state_description_collection;

  /// No description provided for @empty_state_no_reading_novels.
  ///
  /// In en, this message translates to:
  /// **'No Current Reads'**
  String get empty_state_no_reading_novels;

  /// No description provided for @empty_state_description_no_reading_novels.
  ///
  /// In en, this message translates to:
  /// **'You aren\'t reading any novels at the moment.'**
  String get empty_state_description_no_reading_novels;

  /// No description provided for @empty_state_no_completed_novels.
  ///
  /// In en, this message translates to:
  /// **'Empty Shelf'**
  String get empty_state_no_completed_novels;

  /// No description provided for @empty_state_description_no_completed_novels.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t completed any novels yet.'**
  String get empty_state_description_no_completed_novels;

  /// No description provided for @empty_state_no_results_found.
  ///
  /// In en, this message translates to:
  /// **'No Results Found'**
  String get empty_state_no_results_found;

  /// No description provided for @empty_state_description_no_results_found.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search to find what you are looking for.'**
  String get empty_state_description_no_results_found;

  /// No description provided for @tip_double_tap_discover.
  ///
  /// In en, this message translates to:
  /// **'Double tap \"Discover\" to see the WebView.'**
  String get tip_double_tap_discover;

  /// No description provided for @tip_search_globally.
  ///
  /// In en, this message translates to:
  /// **'Double tap \"Search\" to search globally.'**
  String get tip_search_globally;

  /// No description provided for @tip_search_locally.
  ///
  /// In en, this message translates to:
  /// **'Double tap \"Search\" to search locally.'**
  String get tip_search_locally;

  /// No description provided for @tip_open_webview.
  ///
  /// In en, this message translates to:
  /// **'Open WebView to check the content.'**
  String get tip_open_webview;

  /// No description provided for @extension_installed.
  ///
  /// In en, this message translates to:
  /// **'Extension installed'**
  String get extension_installed;

  /// No description provided for @extension_updated.
  ///
  /// In en, this message translates to:
  /// **'Extension updated'**
  String get extension_updated;

  /// No description provided for @failed_to_install.
  ///
  /// In en, this message translates to:
  /// **'Failed to install'**
  String get failed_to_install;

  /// No description provided for @failed_to_update.
  ///
  /// In en, this message translates to:
  /// **'Failed to update'**
  String get failed_to_update;

  /// No description provided for @exception_extension_not_found.
  ///
  /// In en, this message translates to:
  /// **'Extension not found'**
  String get exception_extension_not_found;

  /// No description provided for @exception_novel_not_found.
  ///
  /// In en, this message translates to:
  /// **'Novel not found'**
  String get exception_novel_not_found;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
