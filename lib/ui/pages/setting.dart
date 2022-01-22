import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/services/toast_service.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/store/profil/profil_store.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/utils/card/legend_card.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  static const String routeName = '/setting';

  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> {
  late SettingStore _settingStore;
  late CardListStore _cardListStore;
  late ProfilStore _profilStore;
  final ToastService _toastService = ToastService.instance;

  @override
  void initState() {
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    _cardListStore = Provider.of<CardListStore>(context, listen: false);
    _profilStore = Provider.of<ProfilStore>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Observer(builder: (context) {
      return Center(
        child: Column(
          children: [
            LegendCard(
              legend: 'Language',
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 8,
                  bottom: 50,
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
                                      _settingStore.nativeLanguage.value != null ? _settingStore.nativeLanguage.value!.label! : '',
                                      style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color, fontWeight: FontWeight.w500),
                                    )
                                ),
                                isExpanded: true,
                                iconSize: 30,
                                iconEnabledColor: Theme.of(context).textTheme.bodyText2!.color,
                                style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color, fontWeight: FontWeight.w500),
                                items: _settingStore.languages.value != null ? _settingStore.languages.value!.map(
                                      (val) {
                                    return DropdownMenuItem<Language>(
                                      value: val,
                                      child: Text(val.label!),
                                    );
                                  },
                                ).toList() : List.empty(),
                                onChanged: updateNativeLanguage,
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
                                    child: Text(
                                      _settingStore.foreignLanguage.value != null ? _settingStore.foreignLanguage.value!.label! : '',
                                      style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color, fontWeight: FontWeight.w500),
                                    )
                                ),
                                isExpanded: true,
                                iconSize: 30,
                                iconEnabledColor: Theme.of(context).textTheme.bodyText2!.color,
                                style: TextStyle(color: Theme.of(context).textTheme.bodyText2!.color, fontWeight: FontWeight.w500),
                                items: _settingStore.languages.value != null ? _settingStore.languages.value!.map(
                                      (val) {
                                    return DropdownMenuItem<Language>(
                                      value: val,
                                      child: Text(val.label!),
                                    );
                                  },
                                ).toList() : List.empty(),
                                onChanged: updateForeignLanguage,
                              ),
                            )
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 10)
              ]),
            ),
            if (_profilStore.currentProfile.value!.isConnected) LegendCard(
                legend: 'General',
                margin: const EdgeInsets.only(
                    right: 20,
                    left: 20),
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                    const SizedBox(height: 10),
                    Row(
                      children:  [
                        const Expanded(flex: 4, child: Text('Number of success required:')),
                        Expanded(child:
                          Row(
                            children: [
                              Column(children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4),
                                          ),
                                      ),
                                      child: IconButton(onPressed: () => {updateNbSuccessRequired(isUp: true)}, padding: const EdgeInsets.all(0), icon: const Icon(Icons.arrow_drop_up))
                                  ),
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                    child: IconButton(onPressed: updateNbSuccessRequired, padding: const EdgeInsets.all(0), icon: const Icon(Icons.arrow_drop_down))
                                  ),
                                )
                              ],),
                              const SizedBox(width: 5),
                              Text(_profilStore.currentProfile.value!.nbSuccessRequired.toString(),
                                  style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 20)
                              )
                            ],
                          )
                        )
                      ],
                    ),
                    const SizedBox(height: 10)
                  ]
              )
            ) else const SizedBox()
          ],
        ),
      );
    }));
  }

  Decoration _getBoxDecoration() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2));
  }

  void updateNativeLanguage(dynamic val){
    _settingStore.updateNativeLanguage(val).then((_) => _cardListStore.fetchCard());
  }

  void updateForeignLanguage(dynamic val){
    _settingStore.updateForeignLanguage(val).then((_) => _cardListStore.fetchCard());
  }

  void updateNbSuccessRequired({bool isUp = false}){
    final currentNbSuccessRequired = _profilStore.currentProfile.value!.nbSuccessRequired;
    final updatedNbSuccessRequired = isUp ? currentNbSuccessRequired! + 1 : currentNbSuccessRequired! - 1;
    if(updatedNbSuccessRequired < 1) {
      _toastService.toastError("You can't define the number of successes less than 1");
    } else {
      _profilStore.updateNbSuccessRequired(updatedNbSuccessRequired);
    }
  }
}
