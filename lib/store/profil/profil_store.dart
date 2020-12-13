import 'package:flutter_flip_card/data/entities/firebase_user_profil.dart';
import 'package:flutter_flip_card/services/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'profil_store.g.dart';
// flutter pub run build_runner build

class ProfilStore = _ProfilStore with _$ProfilStore;


abstract class _ProfilStore with Store {


  @observable
   UserProfil courantProfil = AuthService.instance.getUser();

  @action
  void logout() {
    AuthService.instance
        .logout()
        .then((value) =>  courantProfil = AuthService.instance.getUser());
  }

  void login() {
    AuthService.instance
        .signInWithGoogle()
        .then((value) =>  courantProfil = AuthService.instance.getUser());
  }

}