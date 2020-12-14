import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_helper.dart';

class FirestoreDictionaryRepository {
  FirestoreDictionaryRepository._privateConstructor();

  final FirestoreHelper _firestoreHelper = FirestoreHelper.instance;

  static final FirestoreDictionaryRepository _instance = FirestoreDictionaryRepository._privateConstructor();
  static FirestoreDictionaryRepository get instance => _instance;

  DocumentReference getUserDictionary(String collectionName, String userId) =>
      _firestoreHelper.getCollection(collectionName).doc(userId);


}