import 'package:mobx/mobx.dart';

part 'interface_store.g.dart';

class InterfaceStore = _InterfaceStore with _$InterfaceStore;

abstract class _InterfaceStore with Store {
  @observable
  ObservableValue<bool> overlayIsDisplayed = Observable<bool>(false);

  @observable
  ObservableValue<bool> overlayIsBuilt = Observable<bool>(false);

  @observable
  ObservableValue<bool> animationIsTerminated = Observable<bool>(false);

  @observable
  ObservableValue<double> addingPopupOffset = Observable<double>(0);

  @observable
  Observable<String?> currentRoute = Observable<String?>(null);

  @observable
  ObservableValue<String> searchBarValue = Observable<String>('');

  @action
  void setSearchBarValue(String value) {
    searchBarValue = Observable<String>(value);
  }

  @action
  void updateAddingPopupOffset(double offset) {
    final updatedOffset = addingPopupOffset.value + offset;
    if (updatedOffset < 0) {
      addingPopupOffset = Observable<double>(updatedOffset);
    }
  }

  @action
  void resetAddingPopupOffset() {
    addingPopupOffset = Observable<double>(0);
  }

  @action
  void buildOverlay() {
    overlayIsBuilt = Observable<bool>(true);
  }

  @action
  void closeOverlay() {
    overlayIsDisplayed = Observable<bool>(false);
    animationIsTerminated = Observable<bool>(false);
  }

  @action
  void openOverlay() {
    overlayIsDisplayed = Observable<bool>(true);
    animationIsTerminated = Observable<bool>(false);
  }

  @action
  void onAnimationTerminated() {
    animationIsTerminated = Observable<bool>(true);
  }

  @action
  void setCurrentRoute(String route) {
    currentRoute = Observable<String>(route);
  }
}
