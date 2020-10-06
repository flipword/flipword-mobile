import 'package:flutter/material.dart';

class AddWordPage extends StatelessWidget {
  static const String routeName = '/add-word';

  const AddWordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Add word',
        style: new TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25.0
        ),
      ),
    );
  }
}
