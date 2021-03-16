import 'package:flutter/material.dart';
import '../core/const.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    @required String hint,
    @required Function onChange,
  })  : _hint = hint,
        _onChange = onChange;

  final String _hint;
  final Function _onChange;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: _screenWidth > 420 ? 300 : _screenWidth - 50,
        decoration: BoxDecoration(
          color: kLightGray,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            child: TextField(
              onChanged: _onChange,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                hintText: _hint,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
