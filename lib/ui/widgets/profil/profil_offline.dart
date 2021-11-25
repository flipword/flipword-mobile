import 'package:flutter/material.dart';
import 'package:flutter_flip_card/ui/widgets/utils/card/legend_card.dart';

class ProfileOffline extends StatelessWidget {
  const ProfileOffline({Key? key}) : super(key: key);

  String get text => 'If you log in to the app, your '
      'will have access to features '
      'not available in offline mode :\n'
      '* sync between device\n'
      '* memorize used language\n'
      '* profile statistics';

  @override
  Widget build(BuildContext context) {
    return LegendCard(
      legend: 'Profile connexion',
      margin: EdgeInsets.only(
          left: 20, right: 20, top: MediaQuery.of(context).size.height / 8),
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
