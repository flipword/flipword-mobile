import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_dictionary_repository.dart';
import 'package:flutter_flip_card/data/entities/word.dart';
import 'package:flutter_flip_card/data/entities/card.dart';

import 'auth_service.dart';
import 'language_service.dart';

class CardService {
  CardService._privateConstructor();

  static const dictionary = 'dictionary';

  //TODO: Injection de dépendance
  final FirestoreDictionaryRepository _repository = FirestoreDictionaryRepository.instance;
  final AuthService _authService = AuthService.instance;
  final LanguageService _languageService = LanguageService.instance;

  static final CardService _instance = CardService._privateConstructor();
  static CardService get instance => _instance;

  CollectionReference getCardCollection() =>
      _repository.getUserDictionary(dictionary, _authService.getUser().uid).collection(_languageService.getRef());

  Future<void> insertCard(Word baseWord, Word translateWord)  async {
    CardEntity card;
    if(baseWord.languageId == _languageService.nativeLanguage.id) {
      card = CardEntity(nativeWord: baseWord, foreignWord: translateWord);
    } else {
      card =  CardEntity(nativeWord: translateWord, foreignWord: baseWord);
    }
    await getCardCollection()
        .add(card.toJson());

    return;
  }

  Future<List<CardEntity>> getListCard() async {
    final response = await getCardCollection().get();
    return response.docs.map((element) {
      var entity = CardEntity.fromJson(element.data());
      entity.id = element.id;
      return entity;
    }).toList();
  }

  Future<void> deleteCard(String id) async {
    return getCardCollection().doc(id).delete();
  }
}