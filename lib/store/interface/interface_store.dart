import 'package:mobx/mobx.dart';

part 'interface_store.g.dart';

class InterfaceStore = _InterfaceStore with _$InterfaceStore;

abstract class _InterfaceStore with Store {
  @observable
  ObservableValue<bool> overlayIsDisplayed = Observable<bool>(false);

  @action
  void closeOverlay(){
    overlayIsDisplayed = Observable<bool>(false);
  }

  @action
  void openOverlay(){
    overlayIsDisplayed = Observable<bool>(true);
  }

}