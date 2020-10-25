import 'package:cloud_firestore/cloud_firestore.dart';
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
  CollectionReference getDicoCollection(){
    List<String> langs = <String>[_languageService.foreignLanguage.id,_languageService.nativeLanguage.id];
    langs.sort();
    // La ref sera id-id des language trier par l'ordre alphabetic
    String ref = langs[0]+'-'+langs[1];
    return firestore.collection(_authService.getUser().uid)
        .doc('dictionary')
        .collection(ref);
  }

  Future<DocumentSnapshot> getDocumentById(String collectionName, String id) => getCollection(collectionName).doc(id).get();

  Future<void> insertDocument(String collectionName, Map<String, dynamic> object) => getCollection(collectionName).add(object);

  deleteDocument(String collectionName, String id) => getCollection(collectionName).doc(id).delete();
}