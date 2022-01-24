import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/icon_text_button.dart';
import 'package:provider/provider.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage(
      {Key? key, this.onClose})
      : super(key: key);

  final VoidCallback? onClose;

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  late SettingStore _settingStore;
  late Language nativeLanguage;
  late Language foreignLanguage;

  @override
  void initState() {
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    nativeLanguage = _settingStore.nativeLanguage.value!;
    foreignLanguage = _settingStore.foreignLanguage.value!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 250),
        child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                const Center(
                  child: Text(
                      'Choose your languages',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20
                      )
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                            'Native language:',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16
                            )
                        )
                    ),
                    Expanded(
                        child: Container(
                            height: 30,
                            decoration: _getBoxDecoration(),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Center(
                                    child: Text(
                                      nativeLanguage.label ?? '',
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
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                            'Foreign language:',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16
                            )
                        )
                    ),
                    Expanded(
                        child: Container(
                            height: 30,
                            decoration: _getBoxDecoration(),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: Center(
                                    child: Text(
                                      foreignLanguage.label ?? '',
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
                const SizedBox(height: 20),
                IconTextButton(
                  width: 90,
                  icon: Icons.save,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  text: 'Save',
                  onPressed: _saveLanguage,
                ),
              ],
            )
        ));
  }

  Decoration _getBoxDecoration() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2));
  }

  void updateNativeLanguage(dynamic val){
    setState(() {
      nativeLanguage = val;
    });
  }

  void updateForeignLanguage(dynamic val){
    setState(() {
      foreignLanguage = val;
    });
  }

  Future<void> _saveLanguage() async {
    await Future.wait([
      _settingStore.updateNativeLanguage(nativeLanguage),
      _settingStore.updateForeignLanguage(foreignLanguage),
    ]);
    widget.onClose!();
  }

  // Use local variable in select & call the store update only in SaveLanguage
  // Check for fetchCard calls

}
