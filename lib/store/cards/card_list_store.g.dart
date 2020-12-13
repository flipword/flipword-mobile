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
  Computed<bool> _$isFinishedComputed;

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

  final _$isFoundAtom = Atom(name: '_CardListStore.isFound');

  @override
  ObservableFuture<bool> get isFound {
    _$isFoundAtom.reportRead();
    return super.isFound;
  }

  @override
  set isFound(ObservableFuture<bool> value) {
    _$isFoundAtom.reportWrite(value, super.isFound, () {
      super.isFound = value;
    });
  }

  final _$foundAtom = Atom(name: '_CardListStore.found');

  @override
  ObservableValue<bool> get found {
    _$foundAtom.reportRead();
    return super.found;
  }

  @override
  set found(ObservableValue<bool> value) {
    _$foundAtom.reportWrite(value, super.found, () {
      super.found = value;
    });
  }

  final _$listAtom = Atom(name: '_CardListStore.list');

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
  void actionOnCard() {
    final _$actionInfo = _$_CardListStoreActionController.startAction(
        name: '_CardListStore.actionOnCard');
    try {
      return super.actionOnCard();
    } finally {
      _$_CardListStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
curentIndex: ${curentIndex},
isFound: ${isFound},
found: ${found},
list: ${list},
length: ${length},
isFinished: ${isFinished}
    ''';
  }
}
