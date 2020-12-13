import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_flip_card/data/entities/firebase_user_profil.dart';
import 'package:flutter_flip_card/services/auth_service.dart';

import 'firestore_helper.dart';

class FirestoreUserProfilRepository {
  FirestoreUserProfilRepository._privateConstructor();

  final FirestoreHelper _firestoreHelper = FirestoreHelper.instance;

  static final FirestoreUserProfilRepository _instance = FirestoreUserProfilRepository._privateConstructor();
  static FirestoreUserProfilRepository get instance => _instance;

  static AuthService firebaseAuthService = AuthService.instance;

  DocumentReference getUserProfilCollection(String userId) =>
      _firestoreHelper.getCollection('UserProfil').doc(userId);

  Future<UserProfil> getUserProfil() async {
    UserProfil firestoreUserProfilRepository;
    await getUserProfilCollection(firebaseAuthService.getUser().uid)
        .get().then((value) => {
      firestoreUserProfilRepository = UserProfil.fromJson(value.data())
    });
    return firestoreUserProfilRepository;
  }

}