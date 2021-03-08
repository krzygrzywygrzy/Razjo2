import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razjo/models/user.dart';
import 'package:razjo/routes/pages/dashboard/bloc/dashboard_bloc.dart';
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

    return Row(
      children: [
        Expanded(
          flex: _size.width < 1200 ? 3 : 2,
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
          child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
            if (state is DashboardHome)
              return Center(
                child: Text("Home"),
              );
            else if (state is DashboardNotes)
              return Center(
                child: Text("Notes"),
              );
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
          }),
        ),
      ],
    );
  }
}
