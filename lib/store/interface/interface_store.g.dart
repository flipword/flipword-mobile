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

  final _$_InterfaceStoreActionController =
      ActionController(name: '_InterfaceStore');

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
  String toString() {
    return '''
overlayIsDisplayed: ${overlayIsDisplayed}
    ''';
  }
}
