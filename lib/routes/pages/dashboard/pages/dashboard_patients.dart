import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/routes/pages/dashboard/widgets/patients_search_display.dart';
import 'package:razjo/services/notification_service.dart';
import '../../../../core/const.dart';
import '../../../../models/user.dart';
import '../widgets/section_top_bar.dart';
import '../../../../services/search_service.dart';
import '../../../../widgets/small_account_card.dart';

class DashboardPatientsPage extends StatefulWidget {
  DashboardPatientsPage({
    @required User user,
  }) : _user = user;

  final User _user;

  @override
  _DashboardPatientsPageState createState() => _DashboardPatientsPageState();
}

class _DashboardPatientsPageState extends State<DashboardPatientsPage> {
  SearchService _searchService = SearchService();
  InvitationService _invitationService = InvitationService();
  int _state = 0;
  User _selectedUser;
  var _phraseController = TextEditingController();

  Widget buildRightSection() {
    switch (_state) {
      case 1:
        return buildSearch();
        break;
      case 2:
        print(widget._user.role);
        return PatientsInfo(selectedUser: _selectedUser, user: widget._user);
        break;
      default:
        return Expanded(
          child: Center(
            child: Text("Choose patient to display information about him/her"),
          ),
        );
        break;
    }
  }

  Widget buildSearch() {
    return StreamBuilder(
      stream: _searchService.resultStream,
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return SmallAccountCard(
                      name:
                          "${snapshot.data[index].name} ${snapshot.data[index].surname}",
                      role: snapshot.data[index].role,
                      email: snapshot.data[index].email,
                      select: () {
                        _selectedUser = snapshot.data[index];
                        _phraseController.clear();
                        setState(() {
                          _state = 2;
                        });
                      },
                    );
                  },
                  itemCount: snapshot.data.length,
                ),
              ),
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: Text("searching..."),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            decoration: BoxDecoration(
              border: kRightBorder,
            ),
            child: Column(
              children: [
                SectionTopBar(
                  children: [
                    Text(
                      "Patients",
                      style: kSubtitle,
                    ),
                  ],
                ),
                buildInvitations(),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              SectionTopBar(
                alignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      onChanged: (value) {
                        if (_state != 1)
                          setState(() {
                            _state = 1;
                          });
                        var role = widget._user.role == "PSY" ? "USR" : "PSY";
                        _searchService.search(value, role);
                      },
                      cursorColor: Theme.of(context).primaryColor,
                      textAlign: TextAlign.end,
                      controller: _phraseController,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: "search",
                        hintStyle: TextStyle(
                          color: kLightGrayAccent,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 4,
                    ),
                    child: Icon(
                      Icons.search,
                      size: 18,
                      color: kLightGrayAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildInvitations() {
    return Container(
      child: FutureBuilder(
        future: _invitationService.getInvitations(widget._user.notifications),
        builder: (BuildContext context,
            AsyncSnapshot<dartz.Either<Failure, List<User>>> snapshot) {
          if (snapshot.hasData && snapshot.data.isRight()) {
            List<User> list = snapshot.data.getOrElse(() => []);
            if (list.length > 0) {
              return Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Text(list[index].name),
                      );
                    },
                  ),
                ),
              );
            } else
              return Container();
          } else {
            //final Failure failure = (snapshot.data as dartz.Left).value;
            return Center(
              child: Text("Loading..."),
            );
          }
        },
      ),
    );
  }
}
