import 'package:flutter_flip_card/const/constants.dart';
import 'package:flutter_flip_card/data/entities/user_profil.dart';
import 'package:flutter_flip_card/services/abstract/abstract_user_profile_service.dart';
import 'package:mobx/mobx.dart';

part 'profil_store.g.dart';
// flutter pub run build_runner build

class ProfilStore = _ProfilStore with _$ProfilStore;


abstract class _ProfilStore with Store {
  final AbstractUserProfileService _userService = AbstractUserProfileService.instance;

  @observable
  ObservableFuture<UserProfil?> currentProfile = ObservableFuture.value(null);

  @action
  Future<void> logout() =>
      currentProfile = ObservableFuture(AbstractUserProfileService.instance.logout().then((value) => value));

  @action
  Future<void> login(SignInMethod signInMethod) =>
      currentProfile = ObservableFuture(AbstractUserProfileService.instance.login(signInMethod).then((value) => value));

  @action
  Future<void> refresh() =>
      currentProfile = ObservableFuture(AbstractUserProfileService.instance.loadCurrentUser().then((value) => value));

  @action
  Future<void> updateNbSuccessRequired(int nbSuccess) => _userService.updateNbSuccessRequired(nbSuccess).then((value){
    final currentProfileCpy = currentProfile.value;
    currentProfileCpy!.nbSuccessRequired = nbSuccess;
    currentProfile = ObservableFuture.value(currentProfileCpy);
    return;
  });

  @action
  Future<void> changeMainOnBoardingStatus() => _userService.changeMainOnBoardingStatus().then((value){
    currentProfile = ObservableFuture.value(currentProfile.value);
    return;
  });

  @action
  Future<void> changeAddingOnBoardingStatus() => _userService.changeAddingOnBoardingStatus().then((value){
    currentProfile = ObservableFuture.value(currentProfile.value);
    return;
  });

}