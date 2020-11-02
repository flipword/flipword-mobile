import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_dictionary_repository.dart';
import 'package:flutter_flip_card/data/entities/card.dart';
import 'package:flutter_flip_card/data/entities/word.dart';

import 'auth_service.dart';
import 'language_service.dart';

class CardService {
  static const dictionary = 'dictionary';

  //TODO: Injection de dépendance
  FirestoreDictionaryRepository _repository = FirestoreDictionaryRepository.instance;
  AuthService _authService = AuthService.instance;
  LanguageService _languageService = LanguageService.instance;


  CardService._privateConstructor();

  static final CardService _instance = CardService._privateConstructor();
  static CardService get instance => _instance;

  CollectionReference getCardCollection() =>
    _repository.getUserDictionary(dictionary, _authService.getUser().uid).collection(_languageService.getRef());

  Future<void> insertCard(Word baseWord, Word translateWord)  async {
    Card card;
    if(baseWord.languageId == _languageService.nativeLanguage.id) {
      card = Card(nativeWord: baseWord, foreignWord: translateWord);
    } else {
      card =  Card(nativeWord: translateWord, foreignWord: baseWord);
    }
    await getCardCollection()
        .add(card.toJson());

    return;
  }

}