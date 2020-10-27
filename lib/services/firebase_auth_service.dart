import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {

  FirebaseAuth auth;
  bool _state = false;

  FirebaseAuthService._privateConstructor(){
    auth ??= FirebaseAuth.instance;
    if(auth.currentUser == null){
       auth.signInAnonymously();
    }
  }

  static final FirebaseAuthService _instance = FirebaseAuthService._privateConstructor();
  static FirebaseAuthService get instance => _instance;

  bool authState() {
    auth.authStateChanges().listen((User user) {
      if (user == null){
        _state = false;
      } else {
        _state = true;
      }});

     return _state;
  }

  User getUser () => auth.currentUser;

  Future<void> logout() async {
    await auth.signOut();
    await auth.signInAnonymously();
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await auth
        .currentUser
        .linkWithCredential(credential)
        .catchError(
            (onError) {
              auth.currentUser.delete();
              auth.signInWithCredential(credential);
            });
    return;
  }


}