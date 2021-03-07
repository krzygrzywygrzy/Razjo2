import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  MenuItem({@required this.isSelected, @required this.label, this.icon, this.select});

  final bool isSelected;
  final String label;
  final IconData icon;
  final Function select;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: select,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 30,
            color: isSelected ? Theme.of(context).primaryColor : Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            icon,
            color: Colors.grey,
            size: 18,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected? Colors.black : Colors.grey,
              fontWeight: isSelected? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
