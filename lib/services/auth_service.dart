import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_user_profil_repository.dart';
import 'package:flutter_flip_card/data/entities/firebase_user_profil.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  AuthService._privateConstructor(){
    _auth ??= FirebaseAuth.instance;
    if(_auth.currentUser == null){
      _auth.signInAnonymously();
    }
  }

  FirebaseAuth _auth;
  final FirestoreUserProfilRepository _firestoreUserProfilRepository = FirestoreUserProfilRepository.instance;

  static final AuthService _instance = AuthService._privateConstructor();
  static AuthService get instance => _instance;

  User getUser () => _auth.currentUser;



  Future<void> logout() async {
    await _auth.signOut();
    await _auth.signInAnonymously();
    return;
  }

  Future<void> signInWithGoogle() async {

    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser
        .authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await _auth
        .currentUser
        .linkWithCredential(credential)
        .catchError(
            (onError) async {
              await _auth.currentUser.delete();
              await _auth.signInWithCredential(credential);
            });
    final profil = FirebaseUserProfil()
      ..email = _auth.currentUser.email
      ..name = _auth.currentUser.displayName;
    await _firestoreUserProfilRepository
        .getUserProfilCollection(_auth.currentUser.uid).set(profil.toJson());

    return;
  }


}