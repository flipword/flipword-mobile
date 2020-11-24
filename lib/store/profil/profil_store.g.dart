// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfilStore on _ProfilStore, Store {
  final _$isConnectAtom = Atom(name: '_ProfilStore.isConnect');

  @override
  bool get isConnect {
    _$isConnectAtom.reportRead();
    return super.isConnect;
  }

  @override
  set isConnect(bool value) {
    _$isConnectAtom.reportWrite(value, super.isConnect, () {
      super.isConnect = value;
    });
  }

  final _$_ProfilStoreActionController = ActionController(name: '_ProfilStore');

  @override
  void setConnection() {
    final _$actionInfo = _$_ProfilStoreActionController.startAction(
        name: '_ProfilStore.setConnection');
    try {
      return super.setConnection();
    } finally {
      _$_ProfilStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isConnect: ${isConnect}
    ''';
  }
}
