// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_card_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LearningCardStore on _LearningCardStore, Store {
  Computed<int> _$lengthComputed;

  @override
  int get length => (_$lengthComputed ??=
          Computed<int>(() => super.length, name: '_LearningCardStore.length'))
      .value;

  final _$curentIndexAtom = Atom(name: '_LearningCardStore.curentIndex');

  @override
  ObservableFuture<int> get curentIndex {
    _$curentIndexAtom.reportRead();
    return super.curentIndex;
  }

  @override
  set curentIndex(ObservableFuture<int> value) {
    _$curentIndexAtom.reportWrite(value, super.curentIndex, () {
      super.curentIndex = value;
    });
  }

  final _$listAtom = Atom(name: '_LearningCardStore.list');

  @override
  ObservableFuture<List<entity.Card>> get list {
    _$listAtom.reportRead();
    return super.list;
  }

  @override
  set list(ObservableFuture<List<entity.Card>> value) {
    _$listAtom.reportWrite(value, super.list, () {
      super.list = value;
    });
  }

  final _$_LearningCardStoreActionController =
      ActionController(name: '_LearningCardStore');

  @override
  Future<void> fetchCard() {
    final _$actionInfo = _$_LearningCardStoreActionController.startAction(
        name: '_LearningCardStore.fetchCard');
    try {
      return super.fetchCard();
    } finally {
      _$_LearningCardStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
curentIndex: ${curentIndex},
list: ${list},
length: ${length}
    ''';
  }
}
