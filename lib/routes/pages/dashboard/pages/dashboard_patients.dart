import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:razjo/core/erros/failures.dart';
import 'package:razjo/models/contact.dart';
import 'package:razjo/routes/pages/dashboard/widgets/patients_search_display.dart';
import 'package:razjo/services/contact_service.dart';
import 'package:razjo/services/notification_service.dart';
import 'package:razjo/services/user_service.dart';
import 'package:razjo/widgets/account_accept_card.dart';
import '../../../../core/const.dart';
import '../../../../models/user.dart';
import '../widgets/section_top_bar.dart';
import '../../../../services/search_service.dart';
import '../../../../widgets/small_account_card.dart';

class DashboardPatientsPage extends StatefulWidget {
  DashboardPatientsPage({
    @required User user,
    @required List<Contact> contacts,
  })  : _user = user,
        _contacts = contacts;

  final User _user;
  final List<Contact> _contacts;

  @override
  _DashboardPatientsPageState createState() => _DashboardPatientsPageState();
}

//TODO: move some elements to separate file

class _DashboardPatientsPageState extends State<DashboardPatientsPage> {
  SearchService _searchService = SearchService();
  InvitationService _invitationService = InvitationService();
  ContactService _contactService = ContactService();
  UserService _userService = UserService();
  int _state = 0;
  User _selectedUser;
  var _phraseController = TextEditingController();

  Widget buildRightSection() {
    switch (_state) {
      case 1:
        return buildSearch();
        break;
      case 2:
        bool inContact = false;
        Contact actualContact;
        for (Contact contact in widget._contacts) {
          if (widget._user.role == "PSY") {
            if (contact.patientId == _selectedUser.id) {
              inContact = true;
              actualContact = contact;
              break;
            }
          }
        }
        return PatientsInfo(
          selectedUser: _selectedUser,
          user: widget._user,
          inContact: inContact,
          contact: inContact ? actualContact : null,
        );
        break;
      default:
        return Expanded(
          child: Center(
            child: Text(
              "Choose patient to display information about him/her",
              style: TextStyle(color: kLightGrayAccent),
            ),
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
          //TODO: display errors and information about 0 results
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      buildInvitations(),
                      buildContacts(context),
                    ],
                  ),
                ),
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
              buildRightSection(),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildContacts(context) {
    List<mongo.ObjectId> ids = List.generate(
        widget._contacts.length,
        (index) => widget._user.role == "PSY"
            ? widget._contacts[index].patientId
            : widget._contacts[index].psyId);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: FutureBuilder(
        future: _userService.getUsers(ids),
        builder: (BuildContext context,
            AsyncSnapshot<dartz.Either<Failure, List<User>>> snapshot) {
          if (snapshot.hasData && snapshot.data.isRight()) {
            List<User> list = (snapshot.data as dartz.Right).value;
            List<Widget> children = List.generate(
              list.length,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SmallAccountCard(
                  name: '${list[index].name} ${list[index].surname}',
                  role: '${list[index].role}',
                  email: '${list[index].email}',
                  select: () {
                    setState(() {
                      _selectedUser = list[index];
                      _state = 2;
                    });
                  },
                ),
              ),
            );

            return Column(
              children: children,
            );
          } else
            return Text("Loading");
        },
      ),
    );
  }

  Container buildInvitations() {
    ContactService _contactService;
    return Container(
      child: FutureBuilder(
        future: _invitationService.getInvitations(widget._user.notifications),
        builder: (BuildContext context,
            AsyncSnapshot<dartz.Either<Failure, List<User>>> snapshot) {
          if (snapshot.hasData && snapshot.data.isRight()) {
            List<User> list = (snapshot.data as dartz.Right).value;
            if (list.length > 0) {
              return Padding(
                padding: const EdgeInsets.only(right: 15.0, left: 15, top: 8),
                child: Container(
                  height: list.length * 60.0,
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return AccountAcceptCard(
                        user: list[index],
                        accept: () async {
                          _contactService = ContactService();
                          var res = await _contactService.addContact(
                              widget._user.role == "PSY"
                                  ? widget._user.id
                                  : list[index].id,
                              widget._user.role == "PSY"
                                  ? list[index].id
                                  : widget._user.id);
                          if (res.isRight()) {
                            _invitationService.deleteInvitation(
                                list[index].id, widget._user.notifications);
                            setState(() {
                              list.removeAt(index);
                            });
                          }
                        },
                        delete: () {
                          _invitationService.deleteInvitation(
                              list[index].id, widget._user.notifications);
                          setState(() {
                            list.removeAt(index);
                          });
                        },
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
