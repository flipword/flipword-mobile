import 'package:flutter_flip_card/data/entities/user_profil.dart';
import 'package:flutter_flip_card/services/user_profile_service.dart';
import 'package:mobx/mobx.dart';

part 'profil_store.g.dart';
// flutter pub run build_runner build

class ProfilStore = _ProfilStore with _$ProfilStore;


abstract class _ProfilStore with Store {

  @observable
  ObservableFuture<UserProfil> currentProfile = ObservableFuture.value(null);

  @action
  Future<void> logout() =>
      currentProfile = ObservableFuture(UserProfileService.instance.logout().then((value) => value));

  @action
  Future<void> login() =>
      currentProfile = ObservableFuture(UserProfileService.instance.login().then((value) => value));

  @action
  Future<void> refresh() =>
      currentProfile = ObservableFuture(UserProfileService.instance.loadCurrentUser().then((value) => value));
}