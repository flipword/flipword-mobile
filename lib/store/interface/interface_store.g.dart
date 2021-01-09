// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interface_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InterfaceStore on _InterfaceStore, Store {
  final _$overlayIsDisplayedAtom =
      Atom(name: '_InterfaceStore.overlayIsDisplayed');

  @override
  ObservableValue<bool> get overlayIsDisplayed {
    _$overlayIsDisplayedAtom.reportRead();
    return super.overlayIsDisplayed;
  }

  @override
  set overlayIsDisplayed(ObservableValue<bool> value) {
    _$overlayIsDisplayedAtom.reportWrite(value, super.overlayIsDisplayed, () {
      super.overlayIsDisplayed = value;
    });
  }

  final _$addingPopupOffsetAtom =
      Atom(name: '_InterfaceStore.addingPopupOffset');

  @override
  ObservableValue<double> get addingPopupOffset {
    _$addingPopupOffsetAtom.reportRead();
    return super.addingPopupOffset;
  }

  @override
  set addingPopupOffset(ObservableValue<double> value) {
    _$addingPopupOffsetAtom.reportWrite(value, super.addingPopupOffset, () {
      super.addingPopupOffset = value;
    });
  }

  final _$currentRouteAtom = Atom(name: '_InterfaceStore.currentRoute');

  @override
  Observable<String> get currentRoute {
    _$currentRouteAtom.reportRead();
    return super.currentRoute;
  }

  @override
  set currentRoute(Observable<String> value) {
    _$currentRouteAtom.reportWrite(value, super.currentRoute, () {
      super.currentRoute = value;
    });
  }

  final _$_InterfaceStoreActionController =
      ActionController(name: '_InterfaceStore');

  @override
  void updateAddingPopupOffset(double offset) {
    final _$actionInfo = _$_InterfaceStoreActionController.startAction(
        name: '_InterfaceStore.updateAddingPopupOffset');
    try {
      return super.updateAddingPopupOffset(offset);
    } finally {
      _$_InterfaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetAddingPopupOffset() {
    final _$actionInfo = _$_InterfaceStoreActionController.startAction(
        name: '_InterfaceStore.resetAddingPopupOffset');
    try {
      return super.resetAddingPopupOffset();
    } finally {
      _$_InterfaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void closeOverlay() {
    final _$actionInfo = _$_InterfaceStoreActionController.startAction(
        name: '_InterfaceStore.closeOverlay');
    try {
      return super.closeOverlay();
    } finally {
      _$_InterfaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openOverlay() {
    final _$actionInfo = _$_InterfaceStoreActionController.startAction(
        name: '_InterfaceStore.openOverlay');
    try {
      return super.openOverlay();
    } finally {
      _$_InterfaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentRoute(String route) {
    final _$actionInfo = _$_InterfaceStoreActionController.startAction(
        name: '_InterfaceStore.setCurrentRoute');
    try {
      return super.setCurrentRoute(route);
    } finally {
      _$_InterfaceStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
overlayIsDisplayed: ${overlayIsDisplayed},
addingPopupOffset: ${addingPopupOffset},
currentRoute: ${currentRoute}
    ''';
  }
}
