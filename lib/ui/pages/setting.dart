import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/utils/card/legend_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  void initState() {
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Observer(builder: (_) {
      return LegendCard(
        legend: 'General',
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 8,
            bottom: 200,
            right: 20,
            left: 20),
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
                          Text(_settingStore.nativeLanguage.label),
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
                            Text(_settingStore.foreignLanguage.label),
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
          Text(language.label,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          const SizedBox(width: 8),
          Flexible(
              child: Text(language.isoCode,
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
          child: const SizedBox()),
      context: context);
}
