import 'package:flutter_flip_card/data/entities/card.dart';
import 'package:flutter_flip_card/data/entities/card.dart' as entity;
import 'package:flutter_flip_card/services/card_service.dart';
import 'package:mobx/mobx.dart';

part 'card_list_store.g.dart';

class CardListStore = _CardListStore with _$CardListStore;

abstract class _CardListStore with Store {
  final CardService _cardService = CardService.instance;

  @observable
  ObservableFuture<int> curentIndex = ObservableFuture.value(0);

  @observable
  ObservableFuture<List<CardEntity>> list =
      ObservableFuture.value(<CardEntity>[]);

  @computed
  int get length => list.value!.length;

  @computed
  bool get isFinished => curentIndex.value! >= list.value!.length - 1;

  @action
  void resetIndex() {
    fetchCard();
    curentIndex = ObservableFuture.value(0);
  }

  @action
  Future<void> fetchCard() => list =
      ObservableFuture(_cardService.getListCard().then((values) => values));

  @action
  Future<void> filterCard(String word) async {
    await fetchCard();
    list = ObservableFuture.value(list.value!
        .where((element) =>
            element.nativeWord!
                .toLowerCase()
                .contains(word.toLowerCase()) ||
            element.foreignWord!.toLowerCase().contains(word.toLowerCase()))
        .toList());
  }

  @action
  void wordFinded(CardEntity card) {
    _cardService.updateCardView(card, true);
    _skipWord();
  }

  @action
  void wordMissed(CardEntity card) {
    _cardService.updateCardView(card, false);
    _skipWord();
  }

  void _skipWord() {
    if (!isFinished) {
      curentIndex = ObservableFuture.value(curentIndex.value! + 1);
    }
  }
}
