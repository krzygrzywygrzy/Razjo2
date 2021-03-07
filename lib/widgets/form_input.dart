import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    @required this.hint,
    @required this.onChange,
  });

  final String hint;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: _screenWidth > 420 ? 300 : _screenWidth-50,
        decoration: BoxDecoration(
          color: Color(0xffe0e0e0),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: TextField(
            onChanged: onChange,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
