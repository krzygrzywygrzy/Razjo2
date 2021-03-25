import 'package:flutter/material.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/models/contact.dart';
import 'package:razjo/models/invitation.dart' as model;
import 'package:razjo/models/user.dart';
import 'package:razjo/routes/pages/dashboard/widgets/section_top_bar.dart';
import 'package:razjo/services/notification_service.dart';
import 'package:razjo/widgets/icon_round_button.dart';
import 'package:razjo/widgets/outline_button.dart';

class PatientsInfo extends StatelessWidget {
  PatientsInfo({
    Key key,
    @required User selectedUser,
    @required User user,
    @required bool inContact,
    Contact contact,
  })  : _selectedUser = selectedUser,
        _user = user,
        _inContact = inContact,
        _contact = contact,
        super(key: key);

  final User _selectedUser;
  final User _user;
  final bool _inContact;
  final Contact _contact;

  InvitationService _service;

  Widget bottomSection() {
    if (_inContact) {
      //TODO:
      return Column(
        children: [
          SectionTopBar(
            children: [
              Text("Notes"),
            ],
          ),
        ],
      );
    } else {
      if (_user.role == "PSY")
        return Text("Add this user to your contacts to see more options");
      else {
        return Text("${_selectedUser.description}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60),
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
                  "${_selectedUser.name} ${_selectedUser.surname}",
                  style: kSubtitle,
                ),
                Text(
                  _selectedUser.role == "PSY" ? 'psychologist' : "patient",
                  style: TextStyle(color: kLightGrayAccent),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyOutlineButton(
                      label: _inContact ? "Remove Contact" : "Add Contact",
                      onTap: () {
                        if (_inContact) {
                        } else {
                          _service = InvitationService();
                          _service.sendInviataion(
                            _selectedUser.notifications,
                            model.Invitation(
                              from: _user.id,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60,
                  ),
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                        border: _inContact ? Border() : kBottomBorder),
                  ),
                ),
                SizedBox(height: 8),
                bottomSection(),
              ],
            ),
          ),
          // Message box
          Positioned(
            right: 8,
            bottom: 8,
            child: IconRoundButton(icon: Icons.video_call),
          ),
        ],
      ),
    );
  }
}
