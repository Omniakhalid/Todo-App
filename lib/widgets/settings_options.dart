import 'package:flutter/material.dart';

class SettingsOption extends StatelessWidget {
  final String opt1, opt2;
  final dynamic value1, value2;
  final dynamic selectedValue;
  final Function onChanged;
  SettingsOption(
      {required this.opt1,
        required this.opt2,
        required this.value1,
        required this.value2,
        required this.selectedValue,
        required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      EdgeInsets.symmetric(horizontal: 6).add(EdgeInsets.only(bottom: 20)),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: DropdownButton(
        iconEnabledColor: Theme.of(context).primaryColor,
        isExpanded: true,
        underline: Container(),
        onChanged: (value) {
          onChanged(value);
        },
        value: selectedValue,
        items: [
          DropdownMenuItem(
            child: Text(
              opt1,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            value: value1,
          ),
          DropdownMenuItem(
              child: Text(
                opt2,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              value: value2),
        ],
      ),
    );
  }
}