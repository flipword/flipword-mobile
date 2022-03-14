import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_language_repository.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_translate_repository.dart';
import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/i18n/flipword.g.dart';

import 'abstract/abstract_user_profile_service.dart';

class LanguageService {
  LanguageService._privateConstructor();

  static final Language defaultNativeLanguage =
      Language(isoCode: 'fr', label: 'French');
  static final Language defaultForeignLanguage =
      Language(isoCode: 'en', label: 'English');

  late Language currentNativeLanguage;
  late Language currentForeignLanguage;

  static final LanguageService _instance =
      LanguageService._privateConstructor();
  static LanguageService get instance => _instance;

  final FirestoreLanguageRepository _repository =
      FirestoreLanguageRepository.instance;
  final TranslateHelper _translateRepository = TranslateHelper.instance;
  final AbstractUserProfileService _userProfileService =
      AbstractUserProfileService.instance;

  Future<void> init() async {
    final user = _userProfileService.getUser();
    await _translateRepository.init();
    currentNativeLanguage = user.nativeLanguageIsoCode == null
        ? defaultNativeLanguage
        : await getLanguageByIsoCode(user.nativeLanguageIsoCode);
    currentForeignLanguage = user.foreignLanguageIsoCode == null
        ? defaultForeignLanguage
        : await getLanguageByIsoCode(user.foreignLanguageIsoCode);
  }

  String getRef() {
    return '${currentNativeLanguage.isoCode}-${currentForeignLanguage.isoCode}';
  }

  Future<List<Language>> getLanguages() async {
    final response = await _repository.getLanguages().get();
    return response.docs.map((element) {
      final entity = Language.fromJson(element.data() as Map<String, dynamic>);
      return entity;
    }).toList();
  }

  Future<void> updateNativeLanguage(String? nativeLanguageIsoCode) =>
      _userProfileService.updateNativeLanguage(nativeLanguageIsoCode).then(
          (_) => _repository
                  .getLanguageByIsoCode(nativeLanguageIsoCode)
                  .then((value) {
                currentNativeLanguage =
                    Language.fromJson(value.data() as Map<String, dynamic>);
                LocaleSettings.setLocale(
                    _getAppLocalFromLanguageIsoCode(nativeLanguageIsoCode!));
              }));

  Future<void> updateForeignLanguage(String? foreignLanguageIsoCode) =>
      _userProfileService.updateForeignLanguage(foreignLanguageIsoCode).then(
          (_) => _repository.getLanguageByIsoCode(foreignLanguageIsoCode).then(
              (value) => currentForeignLanguage =
                  Language.fromJson(value.data() as Map<String, dynamic>)));

  Future<Language> getLanguageByIsoCode(String? isoCode) => _repository
      .getLanguageByIsoCode(isoCode)
      .then((value) => Language.fromJson(value.data() as Map<String, dynamic>));

  Future<String?> translate(String? from, String? to, String word) async =>
      _translateRepository.translate(from, to, word);

  AppLocale _getAppLocalFromLanguageIsoCode(String isoCode) {
    switch (isoCode) {
      case 'en':
        return AppLocale.en;
      case 'fr':
        return AppLocale.fr;
      case 'es':
        return AppLocale.es;
      case 'de':
        return AppLocale.de;
      default:
        return AppLocale.en;
    }
  }
}
