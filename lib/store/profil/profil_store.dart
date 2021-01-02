import 'package:flutter_flip_card/data/entities/firebase_user_profil.dart';
import 'package:flutter_flip_card/services/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'profil_store.g.dart';
// flutter pub run build_runner build

class ProfilStore = _ProfilStore with _$ProfilStore;


abstract class _ProfilStore with Store {

  @observable
  ObservableFuture<UserProfil> courantProfil = ObservableFuture.value(null);

  @action
  Future<void> loadProfil() =>
    courantProfil = ObservableFuture(AuthService.instance.updateCourantUser().then((value) => value));

  @action
  Future<void> logout() =>
      courantProfil = ObservableFuture(AuthService.instance.logout().then((value) => value));

  @action
  Future<void> login() =>
      courantProfil = ObservableFuture(AuthService.instance.signInWithGoogle().then((value) => value));
}