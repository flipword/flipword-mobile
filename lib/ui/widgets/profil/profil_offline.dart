import 'package:flutter/material.dart';

class ProfileOffline extends StatelessWidget {
  final text = 'If you log in to the app, your '
      'will have access to features '
      'not available in offline mode :\n'
      '* sync between device\n'
      '* profile statistics';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
