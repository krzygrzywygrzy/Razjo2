import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../core/const.dart';

class IconRoundButton extends StatelessWidget {
  const IconRoundButton({
    @required IconData icon,
  }) : _icon = icon;

  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            _icon,
            color: kLightGrayAccent,
            size: 22,
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: kLightGray,
          ),
        ),
      ),
    );
  }
}
