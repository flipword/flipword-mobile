import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_language_repository.dart';
import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/services/user_profile_service.dart';

class LanguageService {
  LanguageService._privateConstructor();

  static const String defaultNativeLanguageIsoCode = 'fr';
  static const String defaultForeignLanguageIsoCode = 'en';

  static final LanguageService _instance = LanguageService._privateConstructor();
  static LanguageService get instance => _instance;

  final FirestoreLanguageRepository _repository = FirestoreLanguageRepository.instance;
  final UserProfileService _userProfileService = UserProfileService.instance;

  String getRef() {
    final userProfil = _userProfileService.getUser();
    if(!userProfil.isConnected){
      return '${userProfil.nativeLanguageIsoCode}-${userProfil.foreignLanguageIsoCode}';
    } else {
      return '$defaultNativeLanguageIsoCode-$defaultForeignLanguageIsoCode';
    }
  }

  Future<Language> getCurrentNativeLanguage() async {
    final userProfil = _userProfileService.getUser();
    if(!userProfil.isConnected){
      return _repository.getLanguageByIsoCode(userProfil.nativeLanguageIsoCode).then((value) => Language.fromJson(value.data()));
    } else {
      return _repository.getLanguageByIsoCode(defaultNativeLanguageIsoCode).then((value) => Language.fromJson(value.data()));
    }
  }

  Future<Language> getCurrentForeignLanguage() {
    final userProfil = _userProfileService.getUser();
    if(!userProfil.isConnected){
      return _repository.getLanguageByIsoCode(userProfil.foreignLanguageIsoCode).then((value) => Language.fromJson(value.data()));
    } else {
      return _repository.getLanguageByIsoCode(defaultForeignLanguageIsoCode).then((value) => Language.fromJson(value.data()));
    }
  }
}
