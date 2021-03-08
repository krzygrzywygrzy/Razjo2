import 'package:flutter/material.dart';
import 'package:razjo/widgets/menu_item.dart';

class SideMenu extends StatefulWidget {
  SideMenu({@required this.setLayout, this.type});
  final Function setLayout;
  final String type;

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int _selected = 0;

  List<String> labels = [
    "Home",
    "Notes",
    "Appointments",
    "Patients",
    "Settings",
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.note_rounded,
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
            label: index == 3 && widget.type != "PSY" ? "Psychologists" :labels[index],
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
