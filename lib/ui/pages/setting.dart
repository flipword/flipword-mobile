import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:language_pickers/languages.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);
  static const String routeName = '/setting';

  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  SettingStore _settingStore;
  // It's sample code of Dialog Item.
  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          const SizedBox(width: 8),
          Flexible(child: Text('(${language.isoCode})'))
        ],
      );

  void _openLanguagePickerDialog(String value) => showDialog(
      context: context,
      child: LanguagePickerDialog(
          titlePadding: const EdgeInsets.all(8),
          searchInputDecoration: const InputDecoration(hintText: 'Search...'),
          isSearchable: true,
          title: const Text('Select your language'),
          onValuePicked: (Language language) {
            switch (value) {
              case 'native':
                _settingStore.updateNativeLanguage(language);
                break;
              case 'foreign':
                _settingStore.updateForeignLanguage(language);
                break;
            }
          },
          itemBuilder: _buildDialogItem));

  @override
  Widget build(BuildContext context) {
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    return Scaffold(body: Observer(builder: (_) {
      return Card(
        margin:  const EdgeInsets.only(top: 200, bottom: 200, right: 20, left: 20),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("native language"),
                Expanded(
                  child: Center(
                    child: MaterialButton(
                      onPressed: () => _openLanguagePickerDialog('native'),
                      child: Text(_settingStore.nativeLanguage.name),
                    ),
                  ),
                ),
                Text("foreign language"),
                Expanded(
                  child: Center(
                    child: MaterialButton(
                      onPressed: () => _openLanguagePickerDialog('foreign'),
                      child: Text(_settingStore.foreignLanguage.name),
                    ),
                  ),
                ),
              ]),
        ),
      );
    })

        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

// @override
// Widget build(BuildContext context) {
//
//   final _selectedDialogLanguage = _languageService.foreignLanguage;
//
//   return const Scaffold(
//       body: Center(
//           child: Text(
//             'Setting',
//             style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 fontSize: 25.0
//             ),
//           )
//       )
//   );
// }
}
