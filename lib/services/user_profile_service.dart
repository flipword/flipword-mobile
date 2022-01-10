import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_flip_card/const/constants.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_user_profil_repository.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_robohash_repository.dart';
import 'package:flutter_flip_card/data/entities/user_profil.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class UserProfileService {
  UserProfileService._privateConstructor() {
    _auth = FirebaseAuth.instance;
  }

  late UserProfil _currentProfile;
  late FirebaseAuth _auth;

  static final UserProfileService _instance = UserProfileService._privateConstructor();
  static UserProfileService get instance => _instance;

  final FirestoreUserProfilRepository _firestoreUserProfilRepository = FirestoreUserProfilRepository.instance;
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
    await _auth.signOut();
    await _auth.signInAnonymously();
    return loadCurrentUser();
  }

  Future<void> addALearnedWord() async {
    await _firestoreUserProfilRepository
        .getUserProfilCollection(_currentProfile.uid)
        .update({'nbWordLearned': _currentProfile.nbWordLearned! + 1});
    await updateNbWordLearned();
  }

  Future<void> updateNbWordLearned() async {
    return _firestoreUserProfilRepository
        .getUserProfilCollection(_auth.currentUser!.uid)
        .get()
        .then((value) => _currentProfile.nbWordLearned =
            UserProfil.fromJson(value.data() as Map<String, dynamic>).nbWordLearned ?? 0);
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
      await _auth.signInWithCredential(credential);

      // Set firebase auth id as property in profile collection

      await _firestoreUserProfilRepository
          .getUserProfilCollection(_auth.currentUser!.uid)
          .set({
        'uid': _auth.currentUser!.uid,
        'email': _auth.currentUser!.email,
        'name': _auth.currentUser!.displayName,
        'nativeLanguageIsoCode': LanguageService.defaultNativeLanguage.isoCode,
        'foreignLanguageIsoCode': LanguageService.defaultForeignLanguage
            .isoCode,
        'lastConnection': DateTime.now(),
      }, SetOptions(merge: true));
    } catch (_) {
    }
  }

  Future<void> signInWithApple() async {
    try {
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
          webAuthenticationOptions: WebAuthenticationOptions(
              clientId: 'com.flipword.app.register',
              redirectUri: kIsWeb
                  ? Uri.parse('https://flipword.io/')
                  : Uri.parse(
                  'https://mewing-nine-thyme.glitch.me/callbacks/sign_in_with_apple')),
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(oauthCredential);

      // Set firebase auth id as property in profile collection

      await _firestoreUserProfilRepository
          .getUserProfilCollection(_auth.currentUser!.uid)
          .set({
        'uid': _auth.currentUser!.uid,
        'email': _auth.currentUser!.email,
        'name': _auth.currentUser!.displayName,
        'nativeLanguageIsoCode': LanguageService.defaultNativeLanguage.isoCode,
        'foreignLanguageIsoCode': LanguageService.defaultForeignLanguage.isoCode,
        'lastConnection': DateTime.now(),
      }, SetOptions(merge: true));

    } catch (exception) {
      await FirebaseCrashlytics.instance.recordError(exception, null);
    }
  }

  Future<UserProfil> loadCurrentUser() async {
    if (_auth.currentUser == null) {
      try {
        await _auth.signInAnonymously();
      } catch (error) {
        await FirebaseCrashlytics.instance.recordError(error, null);
      }
    }
    if(!_auth.currentUser!.isAnonymous){
      _currentProfile = await _getUserFromConnected();
    } else {
      _currentProfile = _getUserFromAnonymous();
    }
    return _currentProfile;
  }

  UserProfil _getUserFromAnonymous(){
    return UserProfil()
      ..uid = _auth.currentUser!.uid
      ..isConnected = false
      ..name = null
      ..email = null
      ..lastConnection = null;
  }

  Future<UserProfil> _getUserProfileById(String userId){
    return _firestoreUserProfilRepository.getUserProfilById(userId).then((value) => UserProfil.fromJson(value.data() as Map<String, dynamic>));
  }

  Future<UserProfil> _getUserFromConnected() async{
    final responses = await Future.wait([
      _getUserProfileById(_auth.currentUser!.uid),
      robohashHelper.getAvatarPath(_auth.currentUser!.email!).then((value) => value)
    ]);
    final UserProfil userProfile = responses[0] as UserProfil;
    return userProfile
      ..avatarPath = responses[1] as String?
      ..isConnected = true;
  }

  Future<void> updateNativeLanguage(String? nativeLanguageIsoCode) async {
    if(_currentProfile.isConnected){
      return _firestoreUserProfilRepository
          .getUserProfilCollection(_currentProfile.uid)
          .update({'nativeLanguageIsoCode': nativeLanguageIsoCode})
          .then((value) => _currentProfile.nativeLanguageIsoCode = nativeLanguageIsoCode);
    } else {
      return;
    }
  }

  Future<void> updateForeignLanguage(String? foreignLanguageIsoCode) async {
    if(_currentProfile.isConnected){
      return _firestoreUserProfilRepository
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
