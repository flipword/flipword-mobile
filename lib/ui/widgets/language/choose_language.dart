import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/language.dart';
import 'package:flutter_flip_card/i18n/flipword.g.dart';
import 'package:flutter_flip_card/store/setting/setting_store.dart';
import 'package:flutter_flip_card/ui/widgets/utils/button/icon_text_button.dart';
import 'package:provider/provider.dart';

typedef Language2VoidFunc = void Function(Language);

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key, this.pickNative = true, this.onClose})
      : super(key: key);

  final Language2VoidFunc? onClose;
  final bool pickNative;

  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  late SettingStore _settingStore;
  late Language language;

  @override
  void initState() {
    _settingStore = Provider.of<SettingStore>(context, listen: false);
    language = widget.pickNative
        ? _settingStore.nativeLanguage.value!
        : _settingStore.foreignLanguage.value!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 250),
        child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Center(
                  child: Text(
                      widget.pickNative
                          ? t.which_native_language
                          : t.which_foreign_language,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 23,
                        wordSpacing: 1,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w800,
                      )),
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Container(
                        decoration: _getBoxDecoration(),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  language.label ?? '',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .color,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 20),
                                Image.asset(language.flagPath!,
                                    height: 35, width: 35),
                              ],
                            ),
                            isExpanded: true,
                            iconSize: 30,
                            iconEnabledColor:
                                Theme.of(context).textTheme.bodyText2!.color,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .color,
                                fontWeight: FontWeight.w500),
                            items: _settingStore.languages.value != null
                                ? _settingStore.languages.value!.map(
                                    (val) {
                                      return DropdownMenuItem<Language>(
                                        value: val,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              val.label ?? '',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .color,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Image.asset(val.flagPath!,
                                                height: 35, width: 35),
                                          ],
                                        ),
                                      );
                                    },
                                  ).toList()
                                : List.empty(),
                            onChanged: _updateLanguage,
                          ),
                        ))),
                const SizedBox(height: 30),
                Center(
                    child: IconTextButton(
                  width: 90,
                  icon: Icons.save,
                  color: Theme.of(context).primaryColor,
                  text: t.save,
                  onPressed: _saveLanguage,
                )),
              ],
            )));
  }

  Decoration _getBoxDecoration() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2));
  }

  void _updateLanguage(dynamic val) {
    setState(() {
      language = val;
    });
  }

  Future<void> _saveLanguage() async {
    widget.onClose!(language);
  }
}
