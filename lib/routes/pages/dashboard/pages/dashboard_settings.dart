import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:razjo/models/user.dart';
import 'package:razjo/routes/pages/dashboard/widgets/section_top_bar.dart';
import 'package:razjo/routes/pages/dashboard/widgets/settings_input.dart';

import '../../../../core/const.dart';

class DashboardSettingsPage extends StatefulWidget {
  final User user;
  const DashboardSettingsPage({Key key, @required this.user}) : super(key: key);

  @override
  _DashboardSettingsPageState createState() => _DashboardSettingsPageState();
}

class _DashboardSettingsPageState extends State<DashboardSettingsPage> {
  var _nameController = TextEditingController();
  var _surnameController = TextEditingController();
  var _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SectionTopBar(
              children: [
                Text(
                  "Settings",
                  style: kSubtitle,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Primary information",
                  ),
                ],
              ),
            ),
            SettingsInput(
              controller: _nameController,
              hint: "name: ${widget.user.name}",
            ),
            SettingsInput(
              controller: _surnameController,
              hint: "surname: ${widget.user.surname}",
            ),
            SettingsInput(
              controller: _emailController,
              hint: "email: ${widget.user.email}",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(border: kBottomBorder),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          //TODO: save information
                          child: Text("Save"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
