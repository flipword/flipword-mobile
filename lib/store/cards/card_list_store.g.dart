// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CardListStore on _CardListStore, Store {
  Computed<int>? _$lengthComputed;

  @override
  int get length => (_$lengthComputed ??=
          Computed<int>(() => super.length, name: '_CardListStore.length'))
      .value;
  Computed<bool>? _$isFinishedComputed;

  @override
  bool get isFinished =>
      (_$isFinishedComputed ??= Computed<bool>(() => super.isFinished,
              name: '_CardListStore.isFinished'))
          .value;

  final _$curentIndexAtom = Atom(name: '_CardListStore.curentIndex');

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

  final _$filterCardAsyncAction = AsyncAction('_CardListStore.filterCard');

  @override
  Future<void> filterCard(String word) {
    return _$filterCardAsyncAction.run(() => super.filterCard(word));
  }

  final _$_CardListStoreActionController =
      ActionController(name: '_CardListStore');

  @override
  void resetIndex() {
    final _$actionInfo = _$_CardListStoreActionController.startAction(
        name: '_CardListStore.resetIndex');
    try {
      return super.resetIndex();
    } finally {
      _$_CardListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<void> fetchCard() {
    final _$actionInfo = _$_CardListStoreActionController.startAction(
        name: '_CardListStore.fetchCard');
    try {
      return super.fetchCard();
    } finally {
      _$_CardListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void wordFinded(entity.CardEntity card) {
    final _$actionInfo = _$_CardListStoreActionController.startAction(
        name: '_CardListStore.wordFinded');
    try {
      return super.wordFinded(card);
    } finally {
      _$_CardListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void wordMissed(entity.CardEntity card) {
    final _$actionInfo = _$_CardListStoreActionController.startAction(
        name: '_CardListStore.wordMissed');
    try {
      return super.wordMissed(card);
    } finally {
      _$_CardListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
curentIndex: ${curentIndex},
list: ${list},
length: ${length},
isFinished: ${isFinished}
    ''';
  }
}
