
import 'package:flutter_flip_card/services/auth_service.dart';
import 'package:mobx/mobx.dart';

part 'profil_store.g.dart';

class ProfilStore = _ProfilStore with _$ProfilStore;

abstract class _ProfilStore with Store {

  @observable
  bool isConnect = !AuthService.instance.getUser().isAnonymous;

  @action
  void setConnection() => isConnect = !isConnect;

}