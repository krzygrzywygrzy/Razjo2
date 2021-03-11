import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/models/user.dart';
import 'package:razjo/routes/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:razjo/routes/pages/dashboard/pages/dashboard_home.dart';
import 'package:razjo/routes/pages/dashboard/pages/dashboard_notes.dart';
import 'package:razjo/routes/pages/dashboard/side_menu.dart';
import 'package:razjo/widgets/account_card.dart';

class Dashboard extends StatefulWidget {
  Dashboard({@required this.user});
  final User user;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: Color(0xffdddddd),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: kRightBorder,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AccountCard(
                    name: widget.user.name,
                    surname: widget.user.surname,
                    role: widget.user.role,
                  ),
                  SideMenu(
                    type: widget.user.role,
                    setLayout: (int index) {
                      switch (index) {
                        case 0:
                          context.read<DashboardBloc>().add(GoToHome());
                          break;
                        case 1:
                          context.read<DashboardBloc>().add(GoToNotes());
                          break;
                        case 2:
                          context.read<DashboardBloc>().add(GoToAppointments());
                          break;
                        case 3:
                          context.read<DashboardBloc>().add(GoToPatients());
                          break;
                        case 4:
                          context.read<DashboardBloc>().add(GoToSettings());
                          break;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: Container(
              color: Colors.white,
              child: BlocBuilder<DashboardBloc, DashboardState>(
                  builder: (context, state) {
                if (state is DashboardHome)
                  return DashboardHomePage();
                else if (state is DashboardNotes)
                  return DashboardNotesPage();
                else if (state is DashboardAppointments)
                  return Center(
                    child: Text("Appointments"),
                  );
                else if (state is DashboardPatients)
                  return Center(
                    child: Text("Patients"),
                  );
                else if (state is DashboardSettings)
                  return Center(
                    child: Text("Settings"),
                  );
                else {
                  context.read<DashboardBloc>().add(
                        LoadData(user: widget.user),
                      );
                  return Container();
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
