import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/utils/card/legend_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Center(
                          child: Text(
                            _settingStore.nativeLanguage.value.label,
                            style: TextStyle(color: Theme.of(context).textTheme.bodyText2.color, fontWeight: FontWeight.w500),
                          ),
                        ),
                        isExpanded: true,
                        iconSize: 30,
                        iconEnabledColor: Theme.of(context).textTheme.bodyText2.color,
                        style: TextStyle(color: Theme.of(context).textTheme.bodyText2.color, fontWeight: FontWeight.w500),
                        items: _settingStore.languages.value.map(
                              (val) {
                            return DropdownMenuItem<Language>(
                              value: val,
                              child: Text(val.label),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          _settingStore.updateNativeLanguage(val);
                        },
                      ),
                    )
                  )
              ),
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
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Center(
                            child: _settingStore.foreignLanguage.status == FutureStatus.fulfilled ?
                            Text(
                              _settingStore.foreignLanguage.value.label,
                              style: TextStyle(color: Theme.of(context).textTheme.bodyText2.color, fontWeight: FontWeight.w500),
                            ) :
                            Text(
                              '',
                              style: TextStyle(color: Theme.of(context).textTheme.bodyText2.color, fontWeight: FontWeight.w500),
                            ),
                          ),
                          isExpanded: true,
                          iconSize: 30,
                          iconEnabledColor: Theme.of(context).textTheme.bodyText2.color,
                          style: TextStyle(color: Theme.of(context).textTheme.bodyText2.color, fontWeight: FontWeight.w500),
                          items: _settingStore.languages.value.map(
                                (val) {
                              return DropdownMenuItem<Language>(
                                value: val,
                                child: Text(val.label),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            _settingStore.updateForeignLanguage(val);
                          },
                        ),
                      )
                  )
              ),
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
