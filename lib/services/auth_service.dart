import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_user_profil_repository.dart';
import 'package:flutter_flip_card/data/entities/firebase_user_profil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class AuthService {

  AuthService._privateConstructor(){
    _auth ??= FirebaseAuth.instance;
    if(_auth.currentUser == null){
      _auth.signInAnonymously();

    }

    if(_auth.currentUser.isAnonymous){
      _courantProfil = FirebaseUserProfil()
        ..uid = _auth.currentUser.uid
        ..isConnecter = false;
    }else {
      final now = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
      _courantProfil = FirebaseUserProfil()
        ..email = _auth.currentUser.email
        ..name = _auth.currentUser.displayName
        ..lastConnection = now
        ..uid = _auth.currentUser.uid
        ..isConnecter = true;
    }
  }

  FirebaseUserProfil _courantProfil;
  FirebaseAuth _auth;
  final FirestoreUserProfilRepository _firestoreUserProfilRepository = FirestoreUserProfilRepository.instance;

  static final AuthService _instance = AuthService._privateConstructor();
  static AuthService get instance => _instance;

  FirebaseUserProfil getUser () => _courantProfil;



  Future<void> logout() async {
    await _auth.signOut();
    await _auth.signInAnonymously();
    _courantProfil = FirebaseUserProfil()
      ..uid = _auth.currentUser.uid
      ..isConnecter = false;
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

    final now = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    _courantProfil
      ..email = _auth.currentUser.email
      ..name = _auth.currentUser.displayName
      ..lastConnection = now
      ..uid = _auth.currentUser.uid
      ..isConnecter = true;
    await _firestoreUserProfilRepository
        .getUserProfilCollection(_courantProfil.uid).set(_courantProfil.toJson());

    return;
  }


}