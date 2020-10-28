import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_dictionary_repository.dart';
import 'package:flutter_flip_card/services/card_service.dart';

class ListWordPage extends StatefulWidget {
  static const String routeName = '/list';

  @override
  _State createState() => _State();

}

class _State extends State<ListWordPage> {
  CardService _cardService = CardService.instance;




  String dico;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _cardService.getCardCollection().get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              String r = "";
              snapshot.data.docs.forEach((element) {
                r += '\n'+element.data().toString();
              });
              return Text(r);
            }else{
              return CircularProgressIndicator();
            }},
        ),
        // child: Text(
        //   'List word',
        //   style: new TextStyle(
        //       fontWeight: FontWeight.w500,
        //       fontSize: 25.0
        //   ),
        // ),
      ),
    );
  }
}
