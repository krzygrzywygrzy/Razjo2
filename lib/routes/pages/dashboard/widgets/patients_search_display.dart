import 'package:flutter/material.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/models/invitation.dart' as model;
import 'package:razjo/models/user.dart';
import 'package:razjo/services/notification_service.dart';
import 'package:razjo/widgets/icon_round_button.dart';
import 'package:razjo/widgets/outline_button.dart';

class PatientsInfo extends StatelessWidget {
  PatientsInfo({
    Key key,
    @required User selectedUser,
    @required User user,
  })  : _selectedUser = selectedUser,
        _user = user,
        super(key: key);

  final User _selectedUser;
  final User _user;

  InvitationService _service;

  Widget bottomSection() {
    if (_user.role == "PSY") {
      return Text("Add this user to your patients to see notes");
    } else {
      return Text("PSY description");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Column(
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
                    label: _user.role == "PSY" ? "Add Patient" : "Sign Up",
                    onTap: () {
                      _service = InvitationService();
                      _service.sendInviataion(
                        _selectedUser.notifications,
                        model.Invitation(
                          type: _user.role == "PSY" ? "Add Patient" : "Sign Up",
                          from: _user.id,
                        ),
                      );
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
                  decoration: BoxDecoration(border: kBottomBorder),
                ),
              ),
              SizedBox(height: 8),
              bottomSection(),
            ],
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
