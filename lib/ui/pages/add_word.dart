import 'package:flutter/material.dart';
import 'package:flutter_flip_card/const/colors.dart';
import 'package:flutter_flip_card/ui/themes/theme.dart';

class AddWordPage extends StatelessWidget {
  static const String routeName = '/add-word';

  const AddWordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Add word',
          style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25.0
          ),
        ),
      ) ,
    );
  }
}
