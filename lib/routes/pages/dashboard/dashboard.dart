import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razjo/models/user.dart';
import 'package:razjo/routes/pages/dashboard/side_menu.dart';
import 'package:razjo/widgets/account_card.dart';

class Dashboard extends StatefulWidget {
  Dashboard({@required this.user});
  final User user;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  int _layout = 0;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountCard(
                  name: widget.user.name,
                  surname: widget.user.surname,
                  role: widget.user.role,
                ),
                SideMenu(
                  setLayout: (int index){
                    setState(() {
                      _layout= index;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white,
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

