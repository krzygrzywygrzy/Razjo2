import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../core/const.dart';

class MenuItem extends StatelessWidget {
  MenuItem({
    @required bool isSelected,
    @required String label,
    IconData icon,
    Function select,
  })  : _isSelected = isSelected,
        _label = label,
        _icon = icon,
        _select = select;

  final bool _isSelected;
  final String _label;
  final IconData _icon;
  final Function _select;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _select,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 4,
              height: 30,
              color:
                  _isSelected ? Theme.of(context).primaryColor : Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              _icon,
              color: _isSelected
                  ? Theme.of(context).primaryColor
                  : kLightGrayAccent,
              size: 18,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              _label,
              style: TextStyle(
                color: _isSelected ? kDark : kLightGrayAccent,
                fontWeight: _isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
