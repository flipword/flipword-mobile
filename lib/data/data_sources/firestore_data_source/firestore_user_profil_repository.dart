import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_helper.dart';

class FirestoreUserProfilRepository {
  FirestoreUserProfilRepository._privateConstructor();

  final FirestoreHelper _firestoreHelper = FirestoreHelper.instance;

  static final FirestoreUserProfilRepository _instance = FirestoreUserProfilRepository._privateConstructor();
  static FirestoreUserProfilRepository get instance => _instance;

  DocumentReference getUserDictionary(String userId) =>
      _firestoreHelper.getCollection('UserProfil').doc(userId);

  
}