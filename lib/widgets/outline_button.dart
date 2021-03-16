import 'package:flutter/material.dart';

class MyOutlineButton extends StatelessWidget {
  MyOutlineButton({@required String label}) : _label = label;

  final String _label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_label),
    );
  }
}
