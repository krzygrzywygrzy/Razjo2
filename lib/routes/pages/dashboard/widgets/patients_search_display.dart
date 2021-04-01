import 'package:flutter/material.dart';

import '../../../../core/const.dart';
import '../../../../models/contact.dart';
import '../../../../models/invitation.dart' as model;
import '../../../../models/user.dart';
import '../../../../services/notification_service.dart';
import '../../../../widgets/icon_round_button.dart';
import '../../../../widgets/outline_button.dart';

// ignore: must_be_immutable
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
        super(key: key);

  final User _selectedUser;
  final User _user;
  final bool _inContact;

  InvitationService _service;

  Widget buildDescription() {
    return Text(
        _selectedUser.description != "" && _selectedUser.description != null
            ? _selectedUser.description
            : "Psychologist have not provided descrioption yet!");
  }

  Widget message(String text) {
    return Row(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 15,
            ),
            child: Text(
              "$text",
              textAlign: TextAlign.start,
              style: TextStyle(color: kLightGrayAccent),
            ),
          ),
        ),
      ],
    );
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
                _user.role != "PSY" ? buildDescription() : Container(),
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
