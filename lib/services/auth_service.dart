import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  AuthService._privateConstructor(){
    auth ??= FirebaseAuth.instance;
    if(auth.currentUser == null){
      auth.signInAnonymously();
    }
  }

  FirebaseAuth auth;

  static final AuthService _instance = AuthService._privateConstructor();
  static AuthService get instance => _instance;

  User getUser () => auth.currentUser;



  Future<void> logout() async {
    await auth.signOut();
    await auth.signInAnonymously();
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
    await auth
        .currentUser
        .linkWithCredential(credential)
        .catchError(
            (onError) async {
              await auth.currentUser.delete();
              await auth.signInWithCredential(credential);
            });
    return;
  }


}