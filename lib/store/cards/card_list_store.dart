import 'package:flutter_flip_card/data/entities/card.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_flip_card/services/card_service.dart';
import 'package:flutter_flip_card/data/entities/card.dart' as entity;

part 'card_list_store.g.dart';

class CardListStore = _CardListStore with _$CardListStore;

abstract class _CardListStore with Store {
  final CardService _cardService = CardService.instance;

  @observable
  ObservableFuture<int> curentIndex = ObservableFuture.value(0);

  @observable
  ObservableFuture<bool> isFound = ObservableFuture.value(false);

  @observable
  ObservableValue<bool> found = Observable<bool>(false);

  @observable
  ObservableFuture<List<CardEntity>> list = ObservableFuture.value(<CardEntity>[]);

  @computed
  int get length => list.value.length;

  @computed
  bool get isFinished => curentIndex.value >= list.value.length-1;

  @action
  void resetIndex() {
    curentIndex = ObservableFuture.value(0);
    isFound = ObservableFuture.value(false);
    found = Observable<bool>(false);
  }

  @action
  Future<void> fetchCard() =>
    list = ObservableFuture(_cardService.getListCard().then((values) =>values));

  @action
  void actionOnCard() {
    if (isFound.value) {
        isFound = ObservableFuture.value(false);
        found = Observable<bool>(false);
        if (!isFinished) {
          curentIndex = ObservableFuture.value(curentIndex.value + 1);
        }
    } else
      {
        isFound = ObservableFuture.value(true);
        found = Observable<bool>(true);
      }
  }
}
