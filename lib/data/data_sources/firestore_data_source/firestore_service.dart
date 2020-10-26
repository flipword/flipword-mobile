import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_flip_card/data/entities/dictionary.dart';
import 'package:flutter_flip_card/service/firebaseServices/firebase_auth_service.dart';
import 'package:flutter_flip_card/service/language_service.dart';

class FirestoreService {
  FirebaseFirestore firestore;
  FirebaseAuthService _authService = FirebaseAuthService.instance;
  LanguageService _languageService = LanguageService.instance;

  FirestoreService._privateConstructor(){
    firestore ??= FirebaseFirestore.instance;
  }

  static final FirestoreService _instance = FirestoreService._privateConstructor();
  static FirestoreService get instance => _instance;

  CollectionReference getCollection(String collectionName) => firestore.collection(collectionName);
  CollectionReference getDictionaryCollection(){
    String ref = _languageService.getRef();
    return firestore.collection('dictionary')
        .doc(_authService.getUser().uid)
        .collection(ref);
  }


  Future<DocumentSnapshot> getDocumentById(String collectionName, String id) => getCollection(collectionName).doc(id).get();

  Future<void> insertDocument(String collectionName, Map<String, dynamic> object) => getCollection(collectionName).add(object);
  Future<void> insertWord(Dictionary word) => getDictionaryCollection().doc()
      .set(word.toJson());
  deleteDocument(String collectionName, String id) => getCollection(collectionName).doc(id).delete();
}