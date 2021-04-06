import 'package:flutter/material.dart';

class SettingsInput extends StatelessWidget {
  const SettingsInput({
    Key key,
    this.controller,
    this.hint,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 14),
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
