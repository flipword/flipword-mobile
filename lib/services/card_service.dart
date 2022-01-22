import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_dictionary_repository.dart';
import 'package:flutter_flip_card/data/entities/card.dart';

import 'abstract/abstract_user_profile_service.dart';
import 'language_service.dart';

class CardService {
  CardService._privateConstructor();


  final FirestoreDictionaryRepository _repository =
      FirestoreDictionaryRepository.instance;
  final AbstractUserProfileService _authService = AbstractUserProfileService.instance;
  final LanguageService _languageService = LanguageService.instance;

  static final CardService _instance = CardService._privateConstructor();
  static CardService get instance => _instance;

  CollectionReference getCardCollection() => _repository
      .getUserDictionary(_authService.getUser().uid)
      .collection(_languageService.getRef());

  Future<void> insertCard(String nativeWord, String foreignWord) async {
    final card = CardEntity(nativeWord: nativeWord, foreignWord: foreignWord);
    await getCardCollection().add(card.toJson());
  }

  Future<List<CardEntity>> getListCard() async {
    final response = await getCardCollection().get();
    return response.docs.map((element) {
      final entity = CardEntity.fromJson(element.data() as Map<String, dynamic>)..id = element.id;
      return entity;
    }).toList();
  }

  Future<void> deleteCard(String? id) async {
    return getCardCollection().doc(id).delete();
  }

  Future<void> updateCardView(CardEntity card, bool success) async {
    final nbSuccessRequired = _authService.getUser().nbSuccessRequired ?? 5;
    if ((card.nbSuccess! + 1) >= nbSuccessRequired) {
      await deleteCard(card.id);
      if (_authService.getUser().isConnected) {
        await _authService.addALearnedWord();
      }
    } else {
      await getCardCollection().doc(card.id).update({
        success ? 'nbSuccess' : 'nbErrors':
        success ? card.nbSuccess! + 1 : card.nbErrors! + 1
      });
    }
  }
}
