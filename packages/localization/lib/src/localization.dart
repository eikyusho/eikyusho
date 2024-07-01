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
  /// **'Descobrir'**
  String get page_title_discover;

  /// No description provided for @page_title_library.
  ///
  /// In en, this message translates to:
  /// **'Biblioteca'**
  String get page_title_library;

  /// No description provided for @page_title_search.
  ///
  /// In en, this message translates to:
  /// **'Procurar'**
  String get page_title_search;

  /// No description provided for @page_title_browse.
  ///
  /// In en, this message translates to:
  /// **'Navegar'**
  String get page_title_browse;

  /// No description provided for @page_title_settings.
  ///
  /// In en, this message translates to:
  /// **'Configurações'**
  String get page_title_settings;

  /// No description provided for @page_title_extensions.
  ///
  /// In en, this message translates to:
  /// **'Extensões'**
  String get page_title_extensions;

  /// No description provided for @section_title_most_popular.
  ///
  /// In en, this message translates to:
  /// **'Mais popular'**
  String get section_title_most_popular;

  /// No description provided for @section_title_recently_updated.
  ///
  /// In en, this message translates to:
  /// **'Atualizado recentemente'**
  String get section_title_recently_updated;

  /// No description provided for @section_title_pending_updates.
  ///
  /// In en, this message translates to:
  /// **'Atualizações pendentes'**
  String get section_title_pending_updates;

  /// No description provided for @section_title_available_extensions.
  ///
  /// In en, this message translates to:
  /// **'Extensões disponíveis'**
  String get section_title_available_extensions;

  /// No description provided for @section_title_last_used.
  ///
  /// In en, this message translates to:
  /// **'Usado por último'**
  String get section_title_last_used;

  /// No description provided for @section_title_chapters.
  ///
  /// In en, this message translates to:
  /// **'Capítulos'**
  String get section_title_chapters;

  /// No description provided for @section_title_reading.
  ///
  /// In en, this message translates to:
  /// **'Leitura'**
  String get section_title_reading;

  /// No description provided for @section_title_completed.
  ///
  /// In en, this message translates to:
  /// **'Concluído'**
  String get section_title_completed;

  /// No description provided for @section_title_collections.
  ///
  /// In en, this message translates to:
  /// **'Coleções'**
  String get section_title_collections;

  /// No description provided for @settings_title_profile.
  ///
  /// In en, this message translates to:
  /// **'Perfil'**
  String get settings_title_profile;

  /// No description provided for @settings_title_appearance.
  ///
  /// In en, this message translates to:
  /// **'Aparência'**
  String get settings_title_appearance;

  /// No description provided for @settings_title_preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferências'**
  String get settings_title_preferences;

  /// No description provided for @settings_title_notifications.
  ///
  /// In en, this message translates to:
  /// **'Notificações'**
  String get settings_title_notifications;

  /// No description provided for @settings_title_security.
  ///
  /// In en, this message translates to:
  /// **'Segurança'**
  String get settings_title_security;

  /// No description provided for @settings_title_backup_restore.
  ///
  /// In en, this message translates to:
  /// **'Restauração de backup'**
  String get settings_title_backup_restore;

  /// No description provided for @settings_title_about.
  ///
  /// In en, this message translates to:
  /// **'Sobre'**
  String get settings_title_about;

  /// No description provided for @settings_placeholder_system_theme.
  ///
  /// In en, this message translates to:
  /// **'Sistema'**
  String get settings_placeholder_system_theme;

  /// No description provided for @settings_placeholder_dark_theme.
  ///
  /// In en, this message translates to:
  /// **'Escuro'**
  String get settings_placeholder_dark_theme;

  /// No description provided for @settings_placeholder_light_theme.
  ///
  /// In en, this message translates to:
  /// **'Luz'**
  String get settings_placeholder_light_theme;

  /// No description provided for @button_close.
  ///
  /// In en, this message translates to:
  /// **'Fechar'**
  String get button_close;

  /// No description provided for @button_uninstall_extension.
  ///
  /// In en, this message translates to:
  /// **'Desinstalar Extensão'**
  String get button_uninstall_extension;

  /// No description provided for @button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancelar'**
  String get button_cancel;

  /// No description provided for @button_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirme'**
  String get button_confirm;

  /// No description provided for @button_select_source.
  ///
  /// In en, this message translates to:
  /// **'Selecione a fonte'**
  String get button_select_source;

  /// No description provided for @button_webview.
  ///
  /// In en, this message translates to:
  /// **'Visualização da Web'**
  String get button_webview;

  /// No description provided for @button_read.
  ///
  /// In en, this message translates to:
  /// **'Ler'**
  String get button_read;

  /// No description provided for @button_continue_reading.
  ///
  /// In en, this message translates to:
  /// **'Continuar'**
  String get button_continue_reading;

  /// No description provided for @label_version.
  ///
  /// In en, this message translates to:
  /// **'Versão'**
  String get label_version;

  /// No description provided for @label_language.
  ///
  /// In en, this message translates to:
  /// **'Linguagem'**
  String get label_language;

  /// No description provided for @label_chapters.
  ///
  /// In en, this message translates to:
  /// **'Capítulos'**
  String get label_chapters;

  /// No description provided for @label_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get label_status;

  /// No description provided for @label_views.
  ///
  /// In en, this message translates to:
  /// **'Visualizações'**
  String get label_views;

  /// No description provided for @label_show_mode.
  ///
  /// In en, this message translates to:
  /// **'Mostrar em'**
  String get label_show_mode;

  /// No description provided for @hint_search.
  ///
  /// In en, this message translates to:
  /// **'Procurar'**
  String get hint_search;

  /// No description provided for @hint_search_globally.
  ///
  /// In en, this message translates to:
  /// **'Pesquise globalmente'**
  String get hint_search_globally;

  /// No description provided for @hint_search_locally.
  ///
  /// In en, this message translates to:
  /// **'Pesquise localmente'**
  String get hint_search_locally;

  /// No description provided for @meta_disabled.
  ///
  /// In en, this message translates to:
  /// **'Desabilitado'**
  String get meta_disabled;

  /// No description provided for @toggle_active_extension.
  ///
  /// In en, this message translates to:
  /// **'Ativo'**
  String get toggle_active_extension;

  /// No description provided for @toggle_discover_extension.
  ///
  /// In en, this message translates to:
  /// **'Descobrir'**
  String get toggle_discover_extension;

  /// No description provided for @toggle_show_disabled.
  ///
  /// In en, this message translates to:
  /// **'Mostrar desativado'**
  String get toggle_show_disabled;

  /// No description provided for @dialog_uninstall_extension.
  ///
  /// In en, this message translates to:
  /// **'Desinstalar extensão'**
  String get dialog_uninstall_extension;

  /// No description provided for @dialog_description_uninstall_extension.
  ///
  /// In en, this message translates to:
  /// **'Tem certeza de que deseja desinstalar esta extensão?'**
  String get dialog_description_uninstall_extension;

  /// No description provided for @empty_state_no_sources.
  ///
  /// In en, this message translates to:
  /// **'Nenhuma fonte disponível'**
  String get empty_state_no_sources;

  /// No description provided for @empty_state_description_no_sources.
  ///
  /// In en, this message translates to:
  /// **'Você ainda não adicionou nenhuma fonte.'**
  String get empty_state_description_no_sources;

  /// No description provided for @empty_state_no_selected_source.
  ///
  /// In en, this message translates to:
  /// **'Nenhuma fonte selecionada'**
  String get empty_state_no_selected_source;

  /// No description provided for @empty_state_description_no_selected_source.
  ///
  /// In en, this message translates to:
  /// **'Selecione uma fonte para ver a página de descoberta.'**
  String get empty_state_description_no_selected_source;

  /// No description provided for @empty_state_error.
  ///
  /// In en, this message translates to:
  /// **'Algo deu errado'**
  String get empty_state_error;

  /// No description provided for @empty_state_description_error.
  ///
  /// In en, this message translates to:
  /// **'Ocorreu um erro ao carregar a página.'**
  String get empty_state_description_error;

  /// No description provided for @empty_state_error_loading_sources.
  ///
  /// In en, this message translates to:
  /// **'Ocorreu um erro ao carregar as fontes.'**
  String get empty_state_error_loading_sources;

  /// No description provided for @empty_state_error_loading.
  ///
  /// In en, this message translates to:
  /// **'Erro ao carregar'**
  String get empty_state_error_loading;

  /// No description provided for @empty_state_description_error_loading.
  ///
  /// In en, this message translates to:
  /// **'Não foi possível estabelecer uma conexão.'**
  String get empty_state_description_error_loading;

  /// No description provided for @empty_state_error_loading_novel.
  ///
  /// In en, this message translates to:
  /// **'Não foi possível carregar a lista de romances.'**
  String get empty_state_error_loading_novel;

  /// No description provided for @empty_state_collection.
  ///
  /// In en, this message translates to:
  /// **'Sem coleções'**
  String get empty_state_collection;

  /// No description provided for @empty_state_description_collection.
  ///
  /// In en, this message translates to:
  /// **'Crie uma coleção para organizar os seus romances.'**
  String get empty_state_description_collection;

  /// No description provided for @empty_state_no_reading_novels.
  ///
  /// In en, this message translates to:
  /// **'Nenhuma leitura atual'**
  String get empty_state_no_reading_novels;

  /// No description provided for @empty_state_description_no_reading_novels.
  ///
  /// In en, this message translates to:
  /// **'Você não está a ler nenhum romance no momento.'**
  String get empty_state_description_no_reading_novels;

  /// No description provided for @empty_state_no_completed_novels.
  ///
  /// In en, this message translates to:
  /// **'Prateleira Vazia'**
  String get empty_state_no_completed_novels;

  /// No description provided for @empty_state_description_no_completed_novels.
  ///
  /// In en, this message translates to:
  /// **'Você ainda não completou nenhum romance.'**
  String get empty_state_description_no_completed_novels;

  /// No description provided for @empty_state_no_results_found.
  ///
  /// In en, this message translates to:
  /// **'Nenhum resultado encontrado'**
  String get empty_state_no_results_found;

  /// No description provided for @empty_state_description_no_results_found.
  ///
  /// In en, this message translates to:
  /// **'Tente ajustar a sua pesquisa para encontrar o que procura.'**
  String get empty_state_description_no_results_found;

  /// No description provided for @tip_double_tap_discover.
  ///
  /// In en, this message translates to:
  /// **'Toque duas vezes em \"Descobrir\" para ver o WebView.'**
  String get tip_double_tap_discover;

  /// No description provided for @tip_search_globally.
  ///
  /// In en, this message translates to:
  /// **'Toque duas vezes em \"Pesquisar\" para pesquisar globalmente.'**
  String get tip_search_globally;

  /// No description provided for @tip_search_locally.
  ///
  /// In en, this message translates to:
  /// **'Toque duas vezes em “Pesquisar” para pesquisar localmente.'**
  String get tip_search_locally;

  /// No description provided for @tip_open_webview.
  ///
  /// In en, this message translates to:
  /// **'Abra o WebView para verificar o conteúdo.'**
  String get tip_open_webview;

  /// No description provided for @extension_installed.
  ///
  /// In en, this message translates to:
  /// **'Extensão instalada'**
  String get extension_installed;

  /// No description provided for @extension_updated.
  ///
  /// In en, this message translates to:
  /// **'Extensão atualizada'**
  String get extension_updated;

  /// No description provided for @failed_to_install.
  ///
  /// In en, this message translates to:
  /// **'Falha na instalação'**
  String get failed_to_install;

  /// No description provided for @failed_to_update.
  ///
  /// In en, this message translates to:
  /// **'Falha ao atualizar'**
  String get failed_to_update;

  /// No description provided for @exception_extension_not_found.
  ///
  /// In en, this message translates to:
  /// **'Extensão não encontrada'**
  String get exception_extension_not_found;

  /// No description provided for @exception_novel_not_found.
  ///
  /// In en, this message translates to:
  /// **'Romance não encontrado'**
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
