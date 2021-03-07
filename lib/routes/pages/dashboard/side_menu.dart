import 'package:flutter/material.dart';
import 'package:razjo/widgets/menu_item.dart';

class SideMenu extends StatefulWidget {
  SideMenu({this.setLayout});
  final Function setLayout;

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int _selected = 0;

  List<String> labels = [
    "Home",
    "Appointments",
    "Patients",
    "Settings",
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.add_alert,
    Icons.supervised_user_circle,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return MenuItem(
            isSelected: _selected == index ? true : false,
            label: labels[index],
            icon: icons[index],
            select: (){
              setState(() {
                _selected = index;
                widget.setLayout(index);
              });
            },
          );
        },
        itemCount: labels.length,
      ),
    );
  }
}