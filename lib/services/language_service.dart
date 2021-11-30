import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_language_repository.dart';
import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/services/user_profile_service.dart';

class LanguageService {
  LanguageService._privateConstructor();

  static final Language defaultNativeLanguage = Language(isoCode: 'fr', label: 'French');
  static final Language defaultForeignLanguage = Language(isoCode: 'en', label: 'English');

  late Language currentNativeLanguage;
  late Language currentForeignLanguage;

  static final LanguageService _instance = LanguageService._privateConstructor();
  static LanguageService get instance => _instance;

  final FirestoreLanguageRepository _repository = FirestoreLanguageRepository.instance;
  final UserProfileService _userProfileService = UserProfileService.instance;

  Future<void> init() async {
    final user = _userProfileService.getUser();
    if(user.isConnected){
      currentNativeLanguage = await getLanguageByIsoCode(user.nativeLanguageIsoCode);
      currentForeignLanguage = await getLanguageByIsoCode(user.foreignLanguageIsoCode);
    } else {
      currentNativeLanguage = defaultNativeLanguage;
      currentForeignLanguage = defaultForeignLanguage;
    }
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
      _userProfileService.updateNativeLanguage(nativeLanguageIsoCode).then((_) =>
          _repository.getLanguageByIsoCode(nativeLanguageIsoCode).then((value) => currentNativeLanguage = Language.fromJson(value.data() as Map<String, dynamic>)));

  Future<void> updateForeignLanguage(String? foreignLanguageIsoCode) => 
      _userProfileService.updateForeignLanguage(foreignLanguageIsoCode).then((_) =>
          _repository.getLanguageByIsoCode(foreignLanguageIsoCode).then((value) => currentForeignLanguage = Language.fromJson(value.data() as Map<String, dynamic>)));

  Future<Language> getLanguageByIsoCode(String? isoCode) =>
      _repository.getLanguageByIsoCode(isoCode).then((value) => Language.fromJson(value.data() as Map<String, dynamic>));
}
