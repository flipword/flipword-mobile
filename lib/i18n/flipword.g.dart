
/*
 * Generated file. Do not edit.
 *
 * Locales: 4
 * Strings: 176 (44.0 per locale)
 *
 * Built on 2022-03-14 at 16:18 UTC
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
	String get restart => 'Restart';
	String get try_to_guess => 'Try to guess :';
	String get is_it_ok => 'Is it ok ?';
	String get click_to_swap => 'Click to swap the translation direction';
	String get enter_word => 'Enter your word';
	String get translate_help => 'Click to translate the word written in first box';
	String get please_enter_word => 'Please enter a word';
	String get word_saved => 'Word save';
	String get word_save_error => 'Error on save card';
	String get word_translate_error => 'Error on translate card';
	String get card_delete_success => 'Card delete with success';
	String get card_delete_error => 'Error on deleting card';
	String get logout => 'Logout';
	String get login_google => 'Login or Sign in with Google';
	String get login_apple => 'Login or Sign in with Apple';
	String get language => 'Language';
	String get native_language => 'Native language:';
	String get foreign_language => 'Foreign language:';
	String get general => 'General';
	String get nb_success_required => 'Number of success required to delete word:';
	String get nb_success_define_error => 'You can\'t define the number of successes less than 1';
	String get search_word => 'Search word...';
	String get no_word => 'No word';
	String get click_to_add_word => 'Click on "+" to add a word';
	String get word_views => 'Views';
	String get word_success => 'Successes';
	String get word_error => 'Errors';
	String get delete => 'Delete';
	String get mail => 'Email :';
	String get username => 'Username :';
	String get learned_word => 'Learned words';
	String get profile_connexion => 'Profile connexion';
	String get login_disclaimer => 'If you log in to the app, your will have access to features not available in offline mode :\n* sync between device\n* memorize used language\n* profile statistics';
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
	@override String get choose_language => 'W??hlen Sie eine Sprache';
	@override String get choose_language_desc => 'W??hlen Sie eine Sprache, die Sie lernen m??chten.';
	@override String get create_word_list => 'Wortliste erstellen';
	@override String get create_word_list_desc => 'Erstellen Sie Ihre eigene personalisierte Liste, indem Sie unbekannte W??rter hinzuf??gen, die sich t??glich treffen.';
	@override String get create_word_list_more_info => '*Automatische ??bersetzung und Chrome-Erweiterung sind verf??gbar, um diesen Prozess zu erleichtern.';
	@override String get flipword_title => 'Und...Flipword!';
	@override String get flipword_desc => 'Lernen Sie Ihre Wortliste dank umklappbarer Karten.';
	@override String get start => 'Start';
	@override String get which_native_language => 'Was ist deine Sprache ?';
	@override String get which_foreign_language => 'Welche Sprache m??chten Sie lernen?';
	@override String get save => 'Speichern';
	@override String get restart => 'Neu starten';
	@override String get try_to_guess => 'Versuchen zu erraten :';
	@override String get is_it_ok => 'Ist es o.k ?';
	@override String get click_to_swap => 'Klicken Sie auf , um die ??bersetzungsrichtung zu ??ndern';
	@override String get enter_word => 'Schreiben Sie ein Wort';
	@override String get translate_help => 'Klicken Sie, um das im ersten Feld geschriebene Wort zu ??bersetzen';
	@override String get please_enter_word => 'Bitte geben Sie ein Wort ein';
	@override String get word_saved => 'Wort speichern';
	@override String get word_save_error => 'Fehler auf Speicherkarte';
	@override String get word_translate_error => 'Fehler auf der ??bersetzungskarte';
	@override String get card_delete_success => 'Karte mit Erfolg l??schen';
	@override String get card_delete_error => 'Fehler beim L??schen der Karte';
	@override String get logout => 'Ausloggen';
	@override String get login_google => 'Einloggen mit Google';
	@override String get login_apple => 'Einloggen mit Apple';
	@override String get language => 'Sprache';
	@override String get native_language => 'Muttersprache:';
	@override String get foreign_language => 'Fremdsprache:';
	@override String get general => 'Allgemein';
	@override String get nb_success_required => 'Anzahl der zum L??schen des Wortes erforderlichen Erfolge:';
	@override String get nb_success_define_error => 'Sie k??nnen die Anzahl der Erfolge nicht kleiner als 1 definieren';
	@override String get search_word => 'Suchbegriff...';
	@override String get no_word => 'Kein Wort';
	@override String get click_to_add_word => 'Klicken Sie auf "+", um ein Wort hinzuzuf??gen';
	@override String get word_views => 'Ansichten';
	@override String get word_success => 'Erfolg';
	@override String get word_error => 'Fehler';
	@override String get delete => 'L??schen';
	@override String get mail => 'Email :';
	@override String get username => 'Nutzername :';
	@override String get learned_word => 'Gelerntes Wort';
	@override String get profile_connexion => 'Profilverbindung';
	@override String get login_disclaimer => 'Wenn Sie sich bei der App anmelden, haben Sie Zugriff auf Funktionen, die im Offline-Modus nicht verf??gbar sind:\n* Synchronisierung zwischen Ger??t\n* Merken Sie sich die verwendete Sprache\n* Profilstatistiken';
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
	@override String get create_word_list_more_info => '*La traducci??n autom??tica y la extensi??n de Chrome est??n disponibles para facilitar este proceso.';
	@override String get flipword_title => 'Y...Flipword!';
	@override String get flipword_desc => 'Aprende tu lista de palabras gracias a las tarjetas volteables.';
	@override String get start => 'Comienzo';
	@override String get which_native_language => 'Cu??l es su idioma ?';
	@override String get which_foreign_language => 'Qu?? idioma quieres aprender?';
	@override String get save => 'Guardar';
	@override String get restart => 'Reiniciar';
	@override String get try_to_guess => 'Intenta adivinar :';
	@override String get is_it_ok => 'Est?? bien ?';
	@override String get click_to_swap => 'Haga clic para cambiar la direcci??n de traducci??n';
	@override String get enter_word => 'escribe una palabra';
	@override String get translate_help => 'Haga clic para traducir la palabra escrita en el primer cuadro';
	@override String get please_enter_word => 'Por favor ingrese una palabra';
	@override String get word_saved => 'Guardar palabra';
	@override String get word_save_error => 'Error al guardar la tarjeta';
	@override String get word_translate_error => 'Error en la tarjeta de traducci??n';
	@override String get card_delete_success => 'Eliminaci??n de tarjeta con ??xito';
	@override String get card_delete_error => 'Error al eliminar la tarjeta';
	@override String get logout => 'Cerrar sesi??n';
	@override String get login_google => 'Iniciar sesi??n con Google';
	@override String get login_apple => 'Iniciar sesi??n con Apple';
	@override String get language => 'Idioma';
	@override String get native_language => 'Lengua materna:';
	@override String get foreign_language => 'Idioma extranjero:';
	@override String get general => 'General';
	@override String get nb_success_required => 'N??mero de ??xitos necesarios para eliminar la palabra:';
	@override String get nb_success_define_error => 'No puede definir el n??mero de ??xitos menos de 1';
	@override String get search_word => 'Buscar palabra...';
	@override String get no_word => 'Sin palabras';
	@override String get click_to_add_word => 'Haga clic en "+" para agregar una palabra';
	@override String get word_views => 'Vistas';
	@override String get word_success => '??xitos';
	@override String get word_error => 'Errores';
	@override String get delete => 'Eliminar';
	@override String get mail => 'Email :';
	@override String get username => 'Nombre :';
	@override String get learned_word => 'Palabra aprendida';
	@override String get profile_connexion => 'Conexi??n de perfil';
	@override String get login_disclaimer => 'Si inicia sesi??n en la aplicaci??n, tendr?? acceso a funciones que no est??n disponibles en el modo sin conexi??n:\n* sincronizaci??n entre dispositivos\n* memorizar el lenguaje usado\n* estad??sticas de perfil';
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
	@override String get create_word_list => 'Cr??ez une liste de mot';
	@override String get create_word_list_desc => 'Cr??ez votre propre liste personnalis??e en ajoutant des mots inconnus rencontr??s quotidiennement.';
	@override String get create_word_list_more_info => '*La traduction automatique et l\'extension Chrome sont disponibles pour faciliter ce processus.';
	@override String get flipword_title => 'Et...Flipword!';
	@override String get flipword_desc => 'Apprenez votre liste de mots gr??ce ?? des cartes retournables.';
	@override String get start => 'Commencer';
	@override String get which_native_language => 'Quelle est votre langue ?';
	@override String get which_foreign_language => 'Quelle langue voulez vous apprendre ?';
	@override String get save => 'Sauvegarder';
	@override String get restart => 'Recommencer';
	@override String get try_to_guess => 'Essaie de deviner :';
	@override String get is_it_ok => 'Est-ce que c\'est bon ?';
	@override String get click_to_swap => 'Cliquez pour ??changer le sens de traduction';
	@override String get enter_word => 'Ecrivez un mot';
	@override String get translate_help => 'Cliquez pour traduire le mot ??crit dans la premi??re case';
	@override String get please_enter_word => 'Veuillez entrer un mot';
	@override String get word_saved => 'Mot sauvegard??';
	@override String get word_save_error => 'Erreur lors de l\'enregistrement';
	@override String get word_translate_error => 'Erreur lors de la traduction';
	@override String get card_delete_success => 'Suppression de la carte avec succ??s';
	@override String get card_delete_error => 'Error lors de la suppr??ssion de la carte';
	@override String get logout => 'Se d??connecter';
	@override String get login_google => 'Connectez-vous avec Google';
	@override String get login_apple => 'Connectez-vous avec Apple';
	@override String get language => 'Langue';
	@override String get native_language => 'Langue maternelle:';
	@override String get foreign_language => 'Langue ??trang??re:';
	@override String get general => 'G??n??ral';
	@override String get nb_success_required => 'Nombre de succ??s requis pour supprimer le mot:';
	@override String get nb_success_define_error => 'Vous ne pouvez pas d??finir le nombre de succ??s inf??rieur ?? 1';
	@override String get search_word => 'Rechercher un mot...';
	@override String get no_word => 'Pas de mot';
	@override String get click_to_add_word => 'Cliquez sur "+" pour ajouter un mot';
	@override String get word_views => 'Vues';
	@override String get word_success => 'Succ??s';
	@override String get word_error => 'Erreurs';
	@override String get delete => 'Supprimer';
	@override String get mail => 'Email :';
	@override String get username => 'Nom :';
	@override String get learned_word => 'Mot appris';
	@override String get profile_connexion => 'Connexion au profile';
	@override String get login_disclaimer => 'Si vous vous connectez ?? l\'application, vous aurez acc??s ?? des fonctionnalit??s non disponibles en mode hors connexion :\n* synchronisation entre l\'appareil\n* m??moriser la langue utilis??e\n* statistiques de profil';
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
			'restart': 'Restart',
			'try_to_guess': 'Try to guess :',
			'is_it_ok': 'Is it ok ?',
			'click_to_swap': 'Click to swap the translation direction',
			'enter_word': 'Enter your word',
			'translate_help': 'Click to translate the word written in first box',
			'please_enter_word': 'Please enter a word',
			'word_saved': 'Word save',
			'word_save_error': 'Error on save card',
			'word_translate_error': 'Error on translate card',
			'card_delete_success': 'Card delete with success',
			'card_delete_error': 'Error on deleting card',
			'logout': 'Logout',
			'login_google': 'Login or Sign in with Google',
			'login_apple': 'Login or Sign in with Apple',
			'language': 'Language',
			'native_language': 'Native language:',
			'foreign_language': 'Foreign language:',
			'general': 'General',
			'nb_success_required': 'Number of success required to delete word:',
			'nb_success_define_error': 'You can\'t define the number of successes less than 1',
			'search_word': 'Search word...',
			'no_word': 'No word',
			'click_to_add_word': 'Click on "+" to add a word',
			'word_views': 'Views',
			'word_success': 'Successes',
			'word_error': 'Errors',
			'delete': 'Delete',
			'mail': 'Email :',
			'username': 'Username :',
			'learned_word': 'Learned words',
			'profile_connexion': 'Profile connexion',
			'login_disclaimer': 'If you log in to the app, your will have access to features not available in offline mode :\n* sync between device\n* memorize used language\n* profile statistics',
		};
	}
}

extension on _FlipwordDe {
	Map<String, dynamic> _buildFlatMap() {
		return {
			'choose_language': 'W??hlen Sie eine Sprache',
			'choose_language_desc': 'W??hlen Sie eine Sprache, die Sie lernen m??chten.',
			'create_word_list': 'Wortliste erstellen',
			'create_word_list_desc': 'Erstellen Sie Ihre eigene personalisierte Liste, indem Sie unbekannte W??rter hinzuf??gen, die sich t??glich treffen.',
			'create_word_list_more_info': '*Automatische ??bersetzung und Chrome-Erweiterung sind verf??gbar, um diesen Prozess zu erleichtern.',
			'flipword_title': 'Und...Flipword!',
			'flipword_desc': 'Lernen Sie Ihre Wortliste dank umklappbarer Karten.',
			'start': 'Start',
			'which_native_language': 'Was ist deine Sprache ?',
			'which_foreign_language': 'Welche Sprache m??chten Sie lernen?',
			'save': 'Speichern',
			'restart': 'Neu starten',
			'try_to_guess': 'Versuchen zu erraten :',
			'is_it_ok': 'Ist es o.k ?',
			'click_to_swap': 'Klicken Sie auf , um die ??bersetzungsrichtung zu ??ndern',
			'enter_word': 'Schreiben Sie ein Wort',
			'translate_help': 'Klicken Sie, um das im ersten Feld geschriebene Wort zu ??bersetzen',
			'please_enter_word': 'Bitte geben Sie ein Wort ein',
			'word_saved': 'Wort speichern',
			'word_save_error': 'Fehler auf Speicherkarte',
			'word_translate_error': 'Fehler auf der ??bersetzungskarte',
			'card_delete_success': 'Karte mit Erfolg l??schen',
			'card_delete_error': 'Fehler beim L??schen der Karte',
			'logout': 'Ausloggen',
			'login_google': 'Einloggen mit Google',
			'login_apple': 'Einloggen mit Apple',
			'language': 'Sprache',
			'native_language': 'Muttersprache:',
			'foreign_language': 'Fremdsprache:',
			'general': 'Allgemein',
			'nb_success_required': 'Anzahl der zum L??schen des Wortes erforderlichen Erfolge:',
			'nb_success_define_error': 'Sie k??nnen die Anzahl der Erfolge nicht kleiner als 1 definieren',
			'search_word': 'Suchbegriff...',
			'no_word': 'Kein Wort',
			'click_to_add_word': 'Klicken Sie auf "+", um ein Wort hinzuzuf??gen',
			'word_views': 'Ansichten',
			'word_success': 'Erfolg',
			'word_error': 'Fehler',
			'delete': 'L??schen',
			'mail': 'Email :',
			'username': 'Nutzername :',
			'learned_word': 'Gelerntes Wort',
			'profile_connexion': 'Profilverbindung',
			'login_disclaimer': 'Wenn Sie sich bei der App anmelden, haben Sie Zugriff auf Funktionen, die im Offline-Modus nicht verf??gbar sind:\n* Synchronisierung zwischen Ger??t\n* Merken Sie sich die verwendete Sprache\n* Profilstatistiken',
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
			'create_word_list_more_info': '*La traducci??n autom??tica y la extensi??n de Chrome est??n disponibles para facilitar este proceso.',
			'flipword_title': 'Y...Flipword!',
			'flipword_desc': 'Aprende tu lista de palabras gracias a las tarjetas volteables.',
			'start': 'Comienzo',
			'which_native_language': 'Cu??l es su idioma ?',
			'which_foreign_language': 'Qu?? idioma quieres aprender?',
			'save': 'Guardar',
			'restart': 'Reiniciar',
			'try_to_guess': 'Intenta adivinar :',
			'is_it_ok': 'Est?? bien ?',
			'click_to_swap': 'Haga clic para cambiar la direcci??n de traducci??n',
			'enter_word': 'escribe una palabra',
			'translate_help': 'Haga clic para traducir la palabra escrita en el primer cuadro',
			'please_enter_word': 'Por favor ingrese una palabra',
			'word_saved': 'Guardar palabra',
			'word_save_error': 'Error al guardar la tarjeta',
			'word_translate_error': 'Error en la tarjeta de traducci??n',
			'card_delete_success': 'Eliminaci??n de tarjeta con ??xito',
			'card_delete_error': 'Error al eliminar la tarjeta',
			'logout': 'Cerrar sesi??n',
			'login_google': 'Iniciar sesi??n con Google',
			'login_apple': 'Iniciar sesi??n con Apple',
			'language': 'Idioma',
			'native_language': 'Lengua materna:',
			'foreign_language': 'Idioma extranjero:',
			'general': 'General',
			'nb_success_required': 'N??mero de ??xitos necesarios para eliminar la palabra:',
			'nb_success_define_error': 'No puede definir el n??mero de ??xitos menos de 1',
			'search_word': 'Buscar palabra...',
			'no_word': 'Sin palabras',
			'click_to_add_word': 'Haga clic en "+" para agregar una palabra',
			'word_views': 'Vistas',
			'word_success': '??xitos',
			'word_error': 'Errores',
			'delete': 'Eliminar',
			'mail': 'Email :',
			'username': 'Nombre :',
			'learned_word': 'Palabra aprendida',
			'profile_connexion': 'Conexi??n de perfil',
			'login_disclaimer': 'Si inicia sesi??n en la aplicaci??n, tendr?? acceso a funciones que no est??n disponibles en el modo sin conexi??n:\n* sincronizaci??n entre dispositivos\n* memorizar el lenguaje usado\n* estad??sticas de perfil',
		};
	}
}

extension on _FlipwordFr {
	Map<String, dynamic> _buildFlatMap() {
		return {
			'choose_language': 'Choisissez une langue',
			'choose_language_desc': 'Choisissez une langue que vous voulez apprendre.',
			'create_word_list': 'Cr??ez une liste de mot',
			'create_word_list_desc': 'Cr??ez votre propre liste personnalis??e en ajoutant des mots inconnus rencontr??s quotidiennement.',
			'create_word_list_more_info': '*La traduction automatique et l\'extension Chrome sont disponibles pour faciliter ce processus.',
			'flipword_title': 'Et...Flipword!',
			'flipword_desc': 'Apprenez votre liste de mots gr??ce ?? des cartes retournables.',
			'start': 'Commencer',
			'which_native_language': 'Quelle est votre langue ?',
			'which_foreign_language': 'Quelle langue voulez vous apprendre ?',
			'save': 'Sauvegarder',
			'restart': 'Recommencer',
			'try_to_guess': 'Essaie de deviner :',
			'is_it_ok': 'Est-ce que c\'est bon ?',
			'click_to_swap': 'Cliquez pour ??changer le sens de traduction',
			'enter_word': 'Ecrivez un mot',
			'translate_help': 'Cliquez pour traduire le mot ??crit dans la premi??re case',
			'please_enter_word': 'Veuillez entrer un mot',
			'word_saved': 'Mot sauvegard??',
			'word_save_error': 'Erreur lors de l\'enregistrement',
			'word_translate_error': 'Erreur lors de la traduction',
			'card_delete_success': 'Suppression de la carte avec succ??s',
			'card_delete_error': 'Error lors de la suppr??ssion de la carte',
			'logout': 'Se d??connecter',
			'login_google': 'Connectez-vous avec Google',
			'login_apple': 'Connectez-vous avec Apple',
			'language': 'Langue',
			'native_language': 'Langue maternelle:',
			'foreign_language': 'Langue ??trang??re:',
			'general': 'G??n??ral',
			'nb_success_required': 'Nombre de succ??s requis pour supprimer le mot:',
			'nb_success_define_error': 'Vous ne pouvez pas d??finir le nombre de succ??s inf??rieur ?? 1',
			'search_word': 'Rechercher un mot...',
			'no_word': 'Pas de mot',
			'click_to_add_word': 'Cliquez sur "+" pour ajouter un mot',
			'word_views': 'Vues',
			'word_success': 'Succ??s',
			'word_error': 'Erreurs',
			'delete': 'Supprimer',
			'mail': 'Email :',
			'username': 'Nom :',
			'learned_word': 'Mot appris',
			'profile_connexion': 'Connexion au profile',
			'login_disclaimer': 'Si vous vous connectez ?? l\'application, vous aurez acc??s ?? des fonctionnalit??s non disponibles en mode hors connexion :\n* synchronisation entre l\'appareil\n* m??moriser la langue utilis??e\n* statistiques de profil',
		};
	}
}
