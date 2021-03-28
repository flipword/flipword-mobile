import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_helper.dart';

class FirestoreLanguageRepository {
  FirestoreLanguageRepository._privateConstructor();

  static const collectionName = 'language';

  final FirestoreHelper _firestoreHelper = FirestoreHelper.instance;

  static final FirestoreLanguageRepository _instance = FirestoreLanguageRepository._privateConstructor();
  static FirestoreLanguageRepository get instance => _instance;


  CollectionReference getLanguages() =>
      _firestoreHelper.getCollection(collectionName);

  Future<QueryDocumentSnapshot> getLanguageByIsoCode(String isoCode){
    try{
      return getLanguages().where('isoCode', isEqualTo: isoCode).get().then((querySnapshot) => querySnapshot.docs.first);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}