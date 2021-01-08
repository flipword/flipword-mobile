import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/utils/card/legend_card.dart';
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

  @override
  Widget build(BuildContext context) {
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    return Scaffold(body: Observer(builder: (_) {
      return LegendCard(
        legend: 'General',
        margin:
            const EdgeInsets.only(top: 200, bottom: 200, right: 20, left: 20),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(flex: 2, child: Text('Native language:')),
              Expanded(
                  flex: 3,
                  child: Container(
                    height: 30,
                    decoration: _getBoxDecoration(),
                    child: MaterialButton(
                      onPressed: () => _openLanguagePickerDialog('native'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_settingStore.nativeLanguage.name),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(flex: 2, child: Text('Foreign language:')),
              Expanded(
                  flex: 3,
                  child: Container(
                    height: 30,
                    decoration: _getBoxDecoration(),
                    child: MaterialButton(
                        onPressed: () => _openLanguagePickerDialog('foreign'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_settingStore.foreignLanguage.name),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        )),
                  )),
            ],
          ),
          const SizedBox(height: 10)
        ]),
      );
    }));
  }

  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          const SizedBox(width: 8),
          Flexible(
              child: Text('(${language.isoCode})',
                  style: TextStyle(color: Theme.of(context).primaryColor)))
        ],
      );

  Decoration _getBoxDecoration() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2));
  }

  void _openLanguagePickerDialog(String value) => showDialog(
      builder: (_) => Theme(
          data: ThemeData(),
          child: LanguagePickerDialog(
              titlePadding: const EdgeInsets.all(8),
              searchInputDecoration:
                  const InputDecoration(hintText: 'Search...'),
              isSearchable: true,
              searchCursorColor: Colors.orange,
              title: const Text('Select your language',
                  style: TextStyle(color: Colors.orange)),
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
              itemBuilder: _buildDialogItem)),
      context: context);
}
