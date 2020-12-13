// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardListStore on _CardListStore, Store {
  Computed<int> _$lengthComputed;

  @override
  int get length => (_$lengthComputed ??=
          Computed<int>(() => super.length, name: '_CardListStore.length'))
      .value;

  final _$listAtom = Atom(name: '_CardListStore.list');

  @override
  ObservableFuture<List<entity.CardEntity>> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableFuture<List<entity.CardEntity>> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$_CardListStoreActionController =
      ActionController(name: '_CardListStore');

  @override
  Future<dynamic> fetchCard() {
    final _$actionInfo = _$_CardListStoreActionController.startAction(
        name: '_CardListStore.fetchCard');
    try {
      return super.fetchCard();
    } finally {
      _$_CardListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
list: ${list},
length: ${length}
    ''';
  }
}
