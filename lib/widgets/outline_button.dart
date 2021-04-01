import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../core/const.dart';

class MyOutlineButton extends StatelessWidget {
  MyOutlineButton({
    @required String label,
    Function onTap,
  })  : _label = label,
        _onTap = onTap;

  final String _label;
  final Function _onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _onTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: kLightGray,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                _label,
                style: TextStyle(
                  color: kLightGrayAccent,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
