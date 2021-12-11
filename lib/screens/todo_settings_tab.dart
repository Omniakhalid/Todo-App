import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/controllers/settings_provider.dart';
import 'package:todo/widgets/settings_options.dart';

class ToDoSettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 30,
        ),
        child: Column(children: [
          Container(
              alignment: Provider.of<SettingsProvider>(context).locale=='en'?Alignment.centerLeft:Alignment.centerRight,
              margin: EdgeInsets.only(bottom: 10),
              child: Text(AppLocalizations.of(context)!.language_label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ))),
          SettingsOption(
            opt1: 'English',
            opt2: 'العربيه',
            value1: 'en',
            value2: 'ar',
            selectedValue: Provider.of<SettingsProvider>(context).locale,
            onChanged: (locale) {
              Provider.of<SettingsProvider>(context,listen: false).changeLocale(locale);
            },
          ),
          Container(
              alignment: Provider.of<SettingsProvider>(context).locale=='en'?Alignment.centerLeft:Alignment.centerRight,
              margin: EdgeInsets.only(bottom: 10),
              child: Text(AppLocalizations.of(context)!.mode_label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ))),
          SettingsOption(
            opt1: AppLocalizations.of(context)!.light_mode,
            opt2: AppLocalizations.of(context)!.dark_mode,
            value1: ThemeMode.light,
            value2: ThemeMode.dark,
            selectedValue: Provider.of<SettingsProvider>(context).mode,
            onChanged: (mode) {
              Provider.of<SettingsProvider>(context, listen: false).changeMode(mode);
            },
          ),
        ]));
  }
}
