import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_flip_card/const/constants.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_user_profil_repository.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_robohash_repository.dart';
import 'package:flutter_flip_card/data/entities/user_profil.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:flutter_flip_card/services/stub/user_profile_service_stub.dart'
  if (dart.library.io) 'package:flutter_flip_card/services/user_profile_service_m.dart'
  if (dart.library.js) 'package:flutter_flip_card/services/user_profile_service_w.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AbstractUserProfileService {
  late UserProfil _currentProfile;

  static AbstractUserProfileService? _instance;

  static AbstractUserProfileService get instance => _instance ??= getUserProfileService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirestoreUserProfilRepository firestoreUserProfilRepository = FirestoreUserProfilRepository.instance;
  final RobohashHelper robohashHelper = RobohashHelper.instance;

  UserProfil getUser() => _currentProfile;

  Future<UserProfil> login(SignInMethod signInMethod) async {
    switch(signInMethod){
      case SignInMethod.GOOGLE:
        await signInWithGoogle();
        break;
      case SignInMethod.APPLE:
        await signInWithApple();
        break;
    }
    return loadCurrentUser();
  }

  Future<UserProfil> logout() async {
    await auth.signOut();
    await auth.signInAnonymously();
    return loadCurrentUser();
  }

  Future<void> addALearnedWord() async {
    await firestoreUserProfilRepository
        .getUserProfilCollection(_currentProfile.uid)
        .update({'nbWordLearned': _currentProfile.nbWordLearned! + 1});
    await updateNbWordLearned();
  }

  Future<void> updateNbWordLearned() async {
    return firestoreUserProfilRepository
        .getUserProfilCollection(auth.currentUser!.uid)
        .get()
        .then((value) => _currentProfile.nbWordLearned =
        UserProfil.fromJson(value.data() as Map<String, dynamic>).nbWordLearned ?? 0);
  }

  Future<void> updateNbSuccessRequired(int nbSuccessRequired) async {
    return firestoreUserProfilRepository
          .getUserProfilCollection(_currentProfile.uid)
          .update({'nbSuccessRequired': nbSuccessRequired})
          .then((value) => _currentProfile.nbSuccessRequired = nbSuccessRequired);
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final googleAuth = await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await auth.signInWithCredential(credential);

      // Keep user in local storage for web
      await auth.setPersistence(Persistence.LOCAL);

      // Set firebase auth id as property in profile collection
      await firestoreUserProfilRepository
          .getUserProfilCollection(auth.currentUser!.uid)
          .set({
        'uid': auth.currentUser!.uid,
        'email': auth.currentUser!.email,
        'name': auth.currentUser!.displayName,
        'nativeLanguageIsoCode': LanguageService.defaultNativeLanguage.isoCode,
        'foreignLanguageIsoCode': LanguageService.defaultForeignLanguage
            .isoCode,
        'lastConnection': DateTime.now(),
      }, SetOptions(merge: true));
    } catch (_) {
    }
  }

  Future<void> signInWithApple();

  Future<UserProfil> loadCurrentUser() async {
    if (auth.currentUser == null) {
      try {
        await auth.signInAnonymously();
      } catch (error) {
        await FirebaseCrashlytics.instance.recordError(error, null);
      }
    }
    if(!auth.currentUser!.isAnonymous){
      _currentProfile = await _getUserFromConnected();
    } else {
      _currentProfile = _getUserFromAnonymous();
    }
    return _currentProfile;
  }

  UserProfil _getUserFromAnonymous(){
    return UserProfil()
      ..uid = auth.currentUser!.uid
      ..isConnected = false
      ..name = null
      ..email = null
      ..lastConnection = null;
  }

  Future<UserProfil> _getUserProfileById(String userId){
    return firestoreUserProfilRepository.getUserProfilById(userId).then((value) => UserProfil.fromJson(value.data() as Map<String, dynamic>));
  }

  Future<UserProfil> _getUserFromConnected() async{
    final responses = await Future.wait([
      _getUserProfileById(auth.currentUser!.uid),
      robohashHelper.getAvatarPath(auth.currentUser!.email!).then((value) => value)
    ]);
    final UserProfil userProfile = responses[0] as UserProfil;
    return userProfile
      ..avatarPath = responses[1] as String?
      ..isConnected = true;
  }

  Future<void> updateNativeLanguage(String? nativeLanguageIsoCode) async {
    if(_currentProfile.isConnected){
      return firestoreUserProfilRepository
          .getUserProfilCollection(_currentProfile.uid)
          .update({'nativeLanguageIsoCode': nativeLanguageIsoCode})
          .then((value) => _currentProfile.nativeLanguageIsoCode = nativeLanguageIsoCode);
    } else {
      return;
    }
  }

  Future<void> updateForeignLanguage(String? foreignLanguageIsoCode) async {
    if(_currentProfile.isConnected){
      return firestoreUserProfilRepository
          .getUserProfilCollection(_currentProfile.uid)
          .update({'foreignLanguageIsoCode': foreignLanguageIsoCode})
          .then((value) => _currentProfile.foreignLanguageIsoCode = foreignLanguageIsoCode);
    } else {
      return;
    }
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
