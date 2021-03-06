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
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
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
