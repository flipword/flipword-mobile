import 'dart:async';
import 'dart:html' show window;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_flip_card/services/abstract/abstract_user_profile_service.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

AbstractUserProfileService getUserProfileService() => UserProfileServiceW._instance;

// WEB SERVICE
class UserProfileServiceW extends AbstractUserProfileService {
  UserProfileServiceW._privateConstructor();

  static final UserProfileServiceW _instance = UserProfileServiceW._privateConstructor();
  static UserProfileServiceW get instance => _instance;

  @override
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
              redirectUri: Uri.parse('https://${window.location.host}/')
          )
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      // Once signed in, return the UserCredential
      await super.auth.signInWithCredential(oauthCredential);

      // Keep user in local storage for web
      await super.auth.setPersistence(Persistence.LOCAL);

      // Set firebase auth id as property in profile collection
      await super.firestoreUserProfilRepository
          .getUserProfilCollection(super.auth.currentUser!.uid)
          .set({
        'uid': super.auth.currentUser!.uid,
        'email': super.auth.currentUser!.email,
        'name': super.auth.currentUser!.displayName,
        'nativeLanguageIsoCode': LanguageService.defaultNativeLanguage.isoCode,
        'foreignLanguageIsoCode': LanguageService.defaultForeignLanguage.isoCode,
        'lastConnection': DateTime.now(),
        'hasDidMainOnBoarding': true
      }, SetOptions(merge: true));

    } catch (exception) {
      await FirebaseCrashlytics.instance.recordError(exception, null);
    }
  }
}
