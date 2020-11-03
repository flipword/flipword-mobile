import 'package:mobx/mobx.dart';
import 'package:flutter_flip_card/services/card_service.dart';
import 'package:flutter_flip_card/data/entities/card.dart' as entity;

part 'card_list_store.g.dart';

class CardListStore = _CardListStore with _$CardListStore;

abstract class _CardListStore with Store {
  final CardService _cardService = CardService.instance;

  @observable
  ObservableFuture<List<entity.Card>> list = ObservableFuture.value(<entity.Card>[]);

  @computed
  int get length => list.value.length;

  @action
  Future fetchCard() =>
    list = ObservableFuture(_cardService.getListCard().then((values) =>values));
}
