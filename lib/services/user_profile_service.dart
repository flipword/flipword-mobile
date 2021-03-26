import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_user_profil_repository.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_robohash_repository.dart';
import 'package:flutter_flip_card/data/entities/user_profil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class UserProfileService {
  UserProfileService._privateConstructor() {
    _auth ??= FirebaseAuth.instance;
  }

  UserProfil _currentProfile;
  FirebaseAuth _auth;

  static final UserProfileService _instance = UserProfileService._privateConstructor();
  static UserProfileService get instance => _instance;

  final FirestoreUserProfilRepository _firestoreUserProfilRepository = FirestoreUserProfilRepository.instance;
  final RobohashHelper robohashHelper = RobohashHelper.instance;

  UserProfil getUser() => _currentProfile;

  Future<UserProfil> login() async {
    await signInWithGoogle();
    return loadCurrentUser();
  }

  Future<UserProfil> logout() async {
    await _auth.signOut();
    await _auth.signInAnonymously();
    return loadCurrentUser();
  }

  Future<void> addALearnedWord() async {
    await _firestoreUserProfilRepository
        .getUserProfilCollection(_currentProfile.uid)
        .update({'nbWordLearned': _currentProfile.nbWordLearned + 1});
    await updateNbWordLearned();
  }

  Future<void> updateNbWordLearned() async {
    return _firestoreUserProfilRepository
        .getUserProfilCollection(_auth.currentUser.uid)
        .get()
        .then((value) => _currentProfile.nbWordLearned =
            UserProfil.fromJson(value.data()).nbWordLearned ?? 0);
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(credential);

    // Set firebase auth id as property in profile collection
    await _firestoreUserProfilRepository
        .getUserProfilCollection(_auth.currentUser.uid)
        .set({
          'uid': _auth.currentUser.uid,
          'email': _auth.currentUser.email,
          'name': _auth.currentUser.displayName,
          'lastConnection': DateTime.now(),
        }, SetOptions(merge: true));
  }

  Future<UserProfil> loadCurrentUser() async {
    if (_auth.currentUser == null) {
      await _auth.signInAnonymously();
    }

    if(_auth.currentUser.isAnonymous){
      _currentProfile = _getUserFromAnonymous();
    } else {
      _currentProfile = await _getUserFromConnected();
    }
    return _currentProfile;
  }

  UserProfil _getUserFromAnonymous(){
    return UserProfil()
      ..uid = _auth.currentUser.uid
      ..isConnected = false
      ..name = null
      ..email = null
      ..lastConnection = null;
  }

  Future<UserProfil> _getUserFromConnected() async{
    final responses = await Future.wait([
      _firestoreUserProfilRepository.getUserProfil(_auth.currentUser.uid),
      robohashHelper.getAvatare(_auth.currentUser.email).then((value) => value)
    ]);
    final UserProfil userProfile = responses[0];
    return userProfile
      ..fileImage = responses[1]
      ..isConnected = true;
  }
}
