import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_helper.dart';

class FirestoreLanguageRepository {
  FirestoreLanguageRepository._privateConstructor();

  final FirestoreHelper _firestoreHelper = FirestoreHelper.instance;

  static final FirestoreLanguageRepository _instance = FirestoreLanguageRepository._privateConstructor();
  static FirestoreLanguageRepository get instance => _instance;


  CollectionReference getLanguages(String userId) =>
      _firestoreHelper.getCollection('language');
}