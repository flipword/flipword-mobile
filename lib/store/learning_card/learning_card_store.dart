import 'package:flutter_flip_card/services/card_service.dart';
import 'package:flutter_flip_card/data/entities/card.dart' as entity;
import 'package:mobx/mobx.dart';

part 'learning_card_store.g.dart';

class LearningCardStore = _LearningCardStore with _$LearningCardStore;

abstract class _LearningCardStore with Store {
  final CardService _cardService = CardService.instance;

  @observable
  ObservableFuture<List<entity.Card>> list = ObservableFuture.value(<entity.Card>[]);

  @computed
  int get length => list.value.length;

  @action
  Future<void> fetchCard() =>
      list = ObservableFuture(_cardService.getListCard().then((values) =>values));


  /*Future<void> deleteFirstWord() async {
    list = ObservableFuture(_cardService.getListCard());
  }*/

}