import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../core/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../routes/bloc/navigation_bloc.dart';
import '../routes/pages/dashboard/bloc/dashboard_bloc.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    Key key,
    @required String name,
    @required String surname,
    @required String role,
    bool showLogOut,
  })  : _name = name,
        _surname = surname,
        _role = role,
        _showLogOut = showLogOut,
        super(key: key);

  final String _name;
  final String _surname;
  final String _role;
  final bool _showLogOut;

  Widget logOut(context) {
    if (_showLogOut == null || _showLogOut == false)
      return Container();
    else
      return Positioned(
        right: 40,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              context.read<DashboardBloc>().add(GoToHome());
              context.read<NavigationBloc>().add(LogOutEvent());
            },
            child: Icon(
              Icons.logout,
              size: 18,
              color: kLightGrayAccent,
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    child: ClipOval(
                      child: Image(
                        image: AssetImage("assets/aph.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$_name $_surname',
                    style: kSubtitle,
                  ),
                  Text(
                    _role == "PSY" ? 'psychologist' : "patient",
                    style: TextStyle(color: kLightGrayAccent),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
          logOut(context),
        ],
      ),
    );
  }
}
