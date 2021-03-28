import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_helper.dart';

class FirestoreUserProfilRepository {
  FirestoreUserProfilRepository._privateConstructor();

  static const collectionName = 'profile';

  final FirestoreHelper _firestoreHelper = FirestoreHelper.instance;

  static final FirestoreUserProfilRepository _instance = FirestoreUserProfilRepository._privateConstructor();
  static FirestoreUserProfilRepository get instance => _instance;

  DocumentReference getUserProfilCollection(String userId) =>
      _firestoreHelper.getCollection(collectionName).doc(userId);

  Future<DocumentSnapshot> getUserProfilById(String userId) async =>
      getUserProfilCollection(userId).get();

}