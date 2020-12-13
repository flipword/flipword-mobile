import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileOffline extends StatelessWidget {

  final text = 'If you log in to the app, your '
      'will hace access to features '
      'not available in offline mode :\n'
      '* Sync between device\n'
      '* profile statistics';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Text(text)
      ),
    );
  }
}
