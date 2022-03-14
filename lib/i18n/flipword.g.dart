
/*
 * Generated file. Do not edit.
 *
 * Locales: 4
 * Strings: 44 (11.0 per locale)
 *
 * Built on 2022-03-14 at 11:43 UTC
 */

import 'package:flutter/widgets.dart';

const AppLocale _baseLocale = AppLocale.en;
AppLocale _currLocale = _baseLocale;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale {
	en, // 'en' (base locale, fallback)
	de, // 'de'
	es, // 'es'
	fr, // 'fr'
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
_FlipwordEn _t = _currLocale.translations;
_FlipwordEn get t => _t;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class Translations {
	Translations._(); // no constructor

	static _FlipwordEn of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget.translations;
	}
}

class LocaleSettings {
	LocaleSettings._(); // no constructor

	/// Uses locale of the device, fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale useDeviceLocale() {
		final locale = AppLocaleUtils.findDeviceLocale();
		return setLocale(locale);
	}

	/// Sets locale
	/// Returns the locale which has been set.
	static AppLocale setLocale(AppLocale locale) {
		_currLocale = locale;
		_t = _currLocale.translations;

		if (WidgetsBinding.instance != null) {
			// force rebuild if TranslationProvider is used
			_translationProviderKey.currentState?.setLocale(_currLocale);
		}

		return _currLocale;
	}

	/// Sets locale using string tag (e.g. en_US, de-DE, fr)
	/// Fallbacks to base locale.
	/// Returns the locale which has been set.
	static AppLocale setLocaleRaw(String rawLocale) {
		final locale = AppLocaleUtils.parse(rawLocale);
		return setLocale(locale);
	}

	/// Gets current locale.
	static AppLocale get currentLocale {
		return _currLocale;
	}

	/// Gets base locale.
	static AppLocale get baseLocale {
		return _baseLocale;
	}

	/// Gets supported locales in string format.
	static List<String> get supportedLocalesRaw {
		return AppLocale.values
			.map((locale) => locale.languageTag)
			.toList();
	}

	/// Gets supported locales (as Locale objects) with base locale sorted first.
	static List<Locale> get supportedLocales {
		return AppLocale.values
			.map((locale) => locale.flutterLocale)
			.toList();
	}
}

/// Provides utility functions without any side effects.
class AppLocaleUtils {
	AppLocaleUtils._(); // no constructor

	/// Returns the locale of the device as the enum type.
	/// Fallbacks to base locale.
	static AppLocale findDeviceLocale() {
		final String? deviceLocale = WidgetsBinding.instance?.window.locale.toLanguageTag();
		if (deviceLocale != null) {
			final typedLocale = _selectLocale(deviceLocale);
			if (typedLocale != null) {
				return typedLocale;
			}
		}
		return _baseLocale;
	}

	/// Returns the enum type of the raw locale.
	/// Fallbacks to base locale.
	static AppLocale parse(String rawLocale) {
		return _selectLocale(rawLocale) ?? _baseLocale;
	}
}

// context enums

// interfaces generated as mixins

// translation instances

late _FlipwordEn _translationsEn = _FlipwordEn.build();
late _FlipwordDe _translationsDe = _FlipwordDe.build();
late _FlipwordEs _translationsEs = _FlipwordEs.build();
late _FlipwordFr _translationsFr = _FlipwordFr.build();

// extensions for AppLocale

extension AppLocaleExtensions on AppLocale {

	/// Gets the translation instance managed by this library.
	/// [TranslationProvider] is using this instance.
	/// The plural resolvers are set via [LocaleSettings].
	_FlipwordEn get translations {
		switch (this) {
			case AppLocale.en: return _translationsEn;
			case AppLocale.de: return _translationsDe;
			case AppLocale.es: return _translationsEs;
			case AppLocale.fr: return _translationsFr;
		}
	}

	/// Gets a new translation instance.
	/// [LocaleSettings] has no effect here.
	/// Suitable for dependency injection and unit tests.
	///
	/// Usage:
	/// final t = AppLocale.en.build(); // build
	/// String a = t.my.path; // access
	_FlipwordEn build() {
		switch (this) {
			case AppLocale.en: return _FlipwordEn.build();
			case AppLocale.de: return _FlipwordDe.build();
			case AppLocale.es: return _FlipwordEs.build();
			case AppLocale.fr: return _FlipwordFr.build();
		}
	}

	String get languageTag {
		switch (this) {
			case AppLocale.en: return 'en';
			case AppLocale.de: return 'de';
			case AppLocale.es: return 'es';
			case AppLocale.fr: return 'fr';
		}
	}

	Locale get flutterLocale {
		switch (this) {
			case AppLocale.en: return const Locale.fromSubtags(languageCode: 'en');
			case AppLocale.de: return const Locale.fromSubtags(languageCode: 'de');
			case AppLocale.es: return const Locale.fromSubtags(languageCode: 'es');
			case AppLocale.fr: return const Locale.fromSubtags(languageCode: 'fr');
		}
	}
}

extension StringAppLocaleExtensions on String {
	AppLocale? toAppLocale() {
		switch (this) {
			case 'en': return AppLocale.en;
			case 'de': return AppLocale.de;
			case 'es': return AppLocale.es;
			case 'fr': return AppLocale.fr;
			default: return null;
		}
	}
}

// wrappers

GlobalKey<_TranslationProviderState> _translationProviderKey = GlobalKey<_TranslationProviderState>();

class TranslationProvider extends StatefulWidget {
	TranslationProvider({required this.child}) : super(key: _translationProviderKey);

	final Widget child;

	@override
	_TranslationProviderState createState() => _TranslationProviderState();

	static _InheritedLocaleData of(BuildContext context) {
		final inheritedWidget = context.dependOnInheritedWidgetOfExactType<_InheritedLocaleData>();
		if (inheritedWidget == null) {
			throw 'Please wrap your app with "TranslationProvider".';
		}
		return inheritedWidget;
	}
}

class _TranslationProviderState extends State<TranslationProvider> {
	AppLocale locale = _currLocale;

	void setLocale(AppLocale newLocale) {
		setState(() {
			locale = newLocale;
		});
	}

	@override
	Widget build(BuildContext context) {
		return _InheritedLocaleData(
			locale: locale,
			child: widget.child,
		);
	}
}

class _InheritedLocaleData extends InheritedWidget {
	final AppLocale locale;
	Locale get flutterLocale => locale.flutterLocale; // shortcut
	final _FlipwordEn translations; // store translations to avoid switch call

	_InheritedLocaleData({required this.locale, required Widget child})
		: translations = locale.translations, super(child: child);

	@override
	bool updateShouldNotify(_InheritedLocaleData oldWidget) {
		return oldWidget.locale != locale;
	}
}

// pluralization feature not used

// helpers

final _localeRegex = RegExp(r'^([a-z]{2,8})?([_-]([A-Za-z]{4}))?([_-]?([A-Z]{2}|[0-9]{3}))?$');
AppLocale? _selectLocale(String localeRaw) {
	final match = _localeRegex.firstMatch(localeRaw);
	AppLocale? selected;
	if (match != null) {
		final language = match.group(1);
		final country = match.group(5);

		// match exactly
		selected = AppLocale.values
			.cast<AppLocale?>()
			.firstWhere((supported) => supported?.languageTag == localeRaw.replaceAll('_', '-'), orElse: () => null);

		if (selected == null && language != null) {
			// match language
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.startsWith(language) == true, orElse: () => null);
		}

		if (selected == null && country != null) {
			// match country
			selected = AppLocale.values
				.cast<AppLocale?>()
				.firstWhere((supported) => supported?.languageTag.contains(country) == true, orElse: () => null);
		}
	}
	return selected;
}

// translations

// Path: <root>
class _FlipwordEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_FlipwordEn.build();

	/// Access flat map
	dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	// ignore: unused_field
	late final _FlipwordEn _root = this;

	// Translations
	String get choose_language => 'Choose language';
	String get choose_language_desc => 'Choose a language you want to learn.';
	String get create_word_list => 'Create word list';
	String get create_word_list_desc => 'Create your own personalized list by adding unknow words that met daily.';
	String get create_word_list_more_info => '*Automatic translation and Chrome extension is available to facilate this process.';
	String get flipword_title => 'And...Flipword!';
	String get flipword_desc => 'Learn your word list thanks to flippable cards.';
	String get start => 'Start';
	String get which_native_language => 'What is your language ?';
	String get which_foreign_language => 'Which language you want to learn ?';
	String get save => 'Save';
}

// Path: <root>
class _FlipwordDe implements _FlipwordEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_FlipwordDe.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	// ignore: unused_field
	@override late final _FlipwordDe _root = this;

	// Translations
	@override String get choose_language => 'Wählen Sie eine Sprache';
	@override String get choose_language_desc => 'Wählen Sie eine Sprache, die Sie lernen möchten.';
	@override String get create_word_list => 'Wortliste erstellen';
	@override String get create_word_list_desc => 'Erstellen Sie Ihre eigene personalisierte Liste, indem Sie unbekannte Wörter hinzufügen, die sich täglich treffen.';
	@override String get create_word_list_more_info => '*Automatische Übersetzung und Chrome-Erweiterung sind verfügbar, um diesen Prozess zu erleichtern.';
	@override String get flipword_title => 'Und...Flipword!';
	@override String get flipword_desc => 'Lernen Sie Ihre Wortliste dank umklappbarer Karten.';
	@override String get start => 'Start';
	@override String get which_native_language => 'Was ist deine Sprache ?';
	@override String get which_foreign_language => 'Welche Sprache möchten Sie lernen?';
	@override String get save => 'Speichern';
}

// Path: <root>
class _FlipwordEs implements _FlipwordEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_FlipwordEs.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	// ignore: unused_field
	@override late final _FlipwordEs _root = this;

	// Translations
	@override String get choose_language => 'Elige un idioma';
	@override String get choose_language_desc => 'Elige un idioma que quieras aprender.';
	@override String get create_word_list => 'Crear lista de palabras';
	@override String get create_word_list_desc => 'Crea tu propia lista personalizada agregando palabras desconocidas que se encuentran a diario.';
	@override String get create_word_list_more_info => '*La traducción automática y la extensión de Chrome están disponibles para facilitar este proceso.';
	@override String get flipword_title => 'Y...Flipword!';
	@override String get flipword_desc => 'Aprende tu lista de palabras gracias a las tarjetas volteables.';
	@override String get start => 'Comienzo';
	@override String get which_native_language => 'Cuál es su idioma ?';
	@override String get which_foreign_language => 'Qué idioma quieres aprender?';
	@override String get save => 'Salvar';
}

// Path: <root>
class _FlipwordFr implements _FlipwordEn {

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_FlipwordFr.build();

	/// Access flat map
	@override dynamic operator[](String key) => _flatMap[key];

	// Internal flat map initialized lazily
	late final Map<String, dynamic> _flatMap = _buildFlatMap();

	// ignore: unused_field
	@override late final _FlipwordFr _root = this;

	// Translations
	@override String get choose_language => 'Choisissez une langue';
	@override String get choose_language_desc => 'Choisissez une langue que vous voulez apprendre.';
	@override String get create_word_list => 'Créez une liste de mot';
	@override String get create_word_list_desc => 'Créez votre propre liste personnalisée en ajoutant des mots inconnus rencontrés quotidiennement.';
	@override String get create_word_list_more_info => '*La traduction automatique et l\'extension Chrome sont disponibles pour faciliter ce processus.';
	@override String get flipword_title => 'Et...Flipword!';
	@override String get flipword_desc => 'Apprenez votre liste de mots grâce à des cartes retournables.';
	@override String get start => 'Commencer';
	@override String get which_native_language => 'Quelle est votre langue ?';
	@override String get which_foreign_language => 'Quelle langue voulez vous apprendre ?';
	@override String get save => 'Sauvegarder';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on _FlipwordEn {
	Map<String, dynamic> _buildFlatMap() {
		return {
			'choose_language': 'Choose language',
			'choose_language_desc': 'Choose a language you want to learn.',
			'create_word_list': 'Create word list',
			'create_word_list_desc': 'Create your own personalized list by adding unknow words that met daily.',
			'create_word_list_more_info': '*Automatic translation and Chrome extension is available to facilate this process.',
			'flipword_title': 'And...Flipword!',
			'flipword_desc': 'Learn your word list thanks to flippable cards.',
			'start': 'Start',
			'which_native_language': 'What is your language ?',
			'which_foreign_language': 'Which language you want to learn ?',
			'save': 'Save',
		};
	}
}

extension on _FlipwordDe {
	Map<String, dynamic> _buildFlatMap() {
		return {
			'choose_language': 'Wählen Sie eine Sprache',
			'choose_language_desc': 'Wählen Sie eine Sprache, die Sie lernen möchten.',
			'create_word_list': 'Wortliste erstellen',
			'create_word_list_desc': 'Erstellen Sie Ihre eigene personalisierte Liste, indem Sie unbekannte Wörter hinzufügen, die sich täglich treffen.',
			'create_word_list_more_info': '*Automatische Übersetzung und Chrome-Erweiterung sind verfügbar, um diesen Prozess zu erleichtern.',
			'flipword_title': 'Und...Flipword!',
			'flipword_desc': 'Lernen Sie Ihre Wortliste dank umklappbarer Karten.',
			'start': 'Start',
			'which_native_language': 'Was ist deine Sprache ?',
			'which_foreign_language': 'Welche Sprache möchten Sie lernen?',
			'save': 'Speichern',
		};
	}
}

extension on _FlipwordEs {
	Map<String, dynamic> _buildFlatMap() {
		return {
			'choose_language': 'Elige un idioma',
			'choose_language_desc': 'Elige un idioma que quieras aprender.',
			'create_word_list': 'Crear lista de palabras',
			'create_word_list_desc': 'Crea tu propia lista personalizada agregando palabras desconocidas que se encuentran a diario.',
			'create_word_list_more_info': '*La traducción automática y la extensión de Chrome están disponibles para facilitar este proceso.',
			'flipword_title': 'Y...Flipword!',
			'flipword_desc': 'Aprende tu lista de palabras gracias a las tarjetas volteables.',
			'start': 'Comienzo',
			'which_native_language': 'Cuál es su idioma ?',
			'which_foreign_language': 'Qué idioma quieres aprender?',
			'save': 'Salvar',
		};
	}
}

extension on _FlipwordFr {
	Map<String, dynamic> _buildFlatMap() {
		return {
			'choose_language': 'Choisissez une langue',
			'choose_language_desc': 'Choisissez une langue que vous voulez apprendre.',
			'create_word_list': 'Créez une liste de mot',
			'create_word_list_desc': 'Créez votre propre liste personnalisée en ajoutant des mots inconnus rencontrés quotidiennement.',
			'create_word_list_more_info': '*La traduction automatique et l\'extension Chrome sont disponibles pour faciliter ce processus.',
			'flipword_title': 'Et...Flipword!',
			'flipword_desc': 'Apprenez votre liste de mots grâce à des cartes retournables.',
			'start': 'Commencer',
			'which_native_language': 'Quelle est votre langue ?',
			'which_foreign_language': 'Quelle langue voulez vous apprendre ?',
			'save': 'Sauvegarder',
		};
	}
}
