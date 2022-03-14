import 'package:flutter/material.dart';
import 'package:flutter_flip_card/i18n/flipword.g.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';
import 'package:provider/provider.dart';

class ProfileOnline extends StatefulWidget {
  const ProfileOnline({Key? key}) : super(key: key);
  @override
  _ProfileOnline createState() => _ProfileOnline();
}

class _ProfileOnline extends State<ProfileOnline> {
  late ProfilStore _profilStore;
  @override
  void initState() {
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: screenSize.height > 600 ? 150 : 120),
                Card(
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 40),
                            child: Text(
                                '${t.mail} ${_profilStore.currentProfile.value!.email}',
                                style: _buildTextStyle(screenSize))),
                        Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: Text(
                                '${t.username} ${_profilStore.currentProfile.value!.name == '' || _profilStore.currentProfile.value!.name == null ? 'no username' : _profilStore.currentProfile.value!.name}',
                                style: _buildTextStyle(screenSize))),
                        Container(
                          padding: const EdgeInsets.only(
                              right: 40, left: 40, top: 15, bottom: 20),
                          child: CardWord(
                              nativeWord: t.learned_word,
                              foreignWord:
                                  '${_profilStore.currentProfile.value!.nbWordLearned}',
                              color: Theme.of(context).primaryColorLight),
                        )
                      ],
                    ))
              ],
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: screenSize.height > 600 ? 190 : 150,
                  height: screenSize.height > 600 ? 190 : 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor,
                  ),
                )),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        _profilStore.currentProfile.value!.avatarPath!,
                        width: screenSize.height > 600 ? 180 : 140,
                        height: screenSize.height > 600 ? 180 : 140,
                      ),
                    ))),
          ],
        ));
  }

  TextStyle _buildTextStyle(dynamic screenSize) {
    if (screenSize.height > 600) {
      return const TextStyle(fontSize: 15);
    } else {
      return const TextStyle(fontSize: 13);
    }
  }
}
