import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/firebase_user_profil.dart';

import 'package:flutter_flip_card/services/auth_service.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class ProfileOnline extends StatefulWidget {

  const ProfileOnline({Key key}) : super(key: key);

  @override
  _ProfileOnline createState() => _ProfileOnline();
}

class _ProfileOnline extends State<ProfileOnline> {
  UserProfil userProfil = AuthService.instance.getUser();
  CardListStore _cardList;

  @override
  void initState() {
    _cardList = Provider.of<CardListStore>(context, listen: false);
    if (_cardList.list.value.isEmpty) {
      _cardList.fetchCard();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final future = _cardList.list;
    Widget _widgetDisplayed;
    return Observer(builder: (_) {
      switch (future.status) {
        case FutureStatus.pending:
          _widgetDisplayed = const Center(
            child: CircularProgressIndicator(),
          );
          break;
        case FutureStatus.fulfilled:
          _widgetDisplayed = Stack(
            children: [
              Card(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                          child: Text('Email : ${userProfil.email}',
                              style: const TextStyle(fontSize: 20))),
                      Container(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Text('Username : ${userProfil.name == '' ? 'no username': userProfil.name }',
                              style: const TextStyle(fontSize: 20))),
                      Container(
                        padding: const EdgeInsets.only(
                            right: 40,
                            left: 40,
                            top: 15,
                            bottom: 20
                        ),
                        child: CardWord(
                            nativeWord: 'Learned words',
                            foreignWord: _cardList.length.toString()
                        ),
                      )
                    ],
                  )
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context)?.cardColor,
                  ),
                )
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 90,
                    backgroundImage: userProfil.fileImage,
                  ),
               )
              ),
            ],
          );
          break;
        case FutureStatus.rejected:
          _widgetDisplayed = const Center(
              child: Text(
            'Fail',
            textAlign: TextAlign.center,
          ));
          break;
      }
      return _widgetDisplayed;
    });
  }
}
