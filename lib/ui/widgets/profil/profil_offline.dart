import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileOffline extends StatelessWidget {

  final text = 'If you log in to the app, your '
      'will hace access to features '
      'not available in offline mode :';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(text)
        ],
      ),
    );
  }
}
