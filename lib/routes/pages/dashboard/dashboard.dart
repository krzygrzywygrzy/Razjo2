import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/const.dart';
import '../../../models/user.dart';
import 'bloc/dashboard_bloc.dart';
import 'pages/dashboard_home.dart';
import 'pages/dashboard_notes.dart';
import 'pages/dashboard_patients.dart';
import 'pages/dashboard_settings.dart';
import 'side_menu.dart';
import '../../../widgets/account_card.dart';

class Dashboard extends StatefulWidget {
  Dashboard({@required this.user});
  final User user;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.user.contacts);
    context.read<DashboardBloc>().add(
          LoadData(contacts: widget.user.contacts),
        );
  }

  @override
  Widget build(BuildContext context) {
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
                    showLogOut: true,
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
                  return DashboardHomePage(
                    id: widget.user.id,
                  );
                else if (state is DashboardNotes)
                  return DashboardNotesPage(
                    role: widget.user.role,
                    contacts: state.contacts,
                    notes: state.notes,
                    name: '${widget.user.name} ${widget.user.surname}',
                  );
                else if (state is DashboardAppointments)
                  return Center(
                    child: Text("Appointments"),
                  );
                else if (state is DashboardPatients)
                  return DashboardPatientsPage(
                    user: widget.user,
                    contacts: state.contacts,
                  );
                else if (state is DashboardSettings)
                  return DashboardSettingsPage();
                else {
                  return Center(
                    child: Text("loading..."),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
