import 'package:flutter/material.dart';
import 'package:flutter_flip_card/i18n/flipword.g.dart';
import 'package:flutter_flip_card/ui/widgets/utils/card/legend_card.dart';

class ProfileOffline extends StatelessWidget {
  const ProfileOffline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LegendCard(
      legend: t.profile_connexion,
      margin: EdgeInsets.only(
          left: 20, right: 20, top: MediaQuery.of(context).size.height / 8),
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Text(
            t.login_disclaimer,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}
