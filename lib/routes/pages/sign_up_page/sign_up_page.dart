import 'package:flutter/material.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/models/user.dart';
import 'package:razjo/routes/bloc/navigation_bloc.dart';
import 'package:razjo/widgets/form_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name, surname, email, password;
  bool role = false;

  void selectRole() {
    setState(() {
      role = !role;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        SizedBox(
          width: _width > 420 ? 100 : 0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sign Up",
              style: TextStyle(fontSize: 30),
            ),
            Row(
              children: [
                FormInput(
                  hint: "name",
                  onChange: (value) {
                    name = value;
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                FormInput(
                  hint: "surname",
                  onChange: (value) {
                    surname = value;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                FormInput(
                  hint: "email",
                  onChange: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                FormInput(
                  hint: "password",
                  onChange: (value) {
                    password = value;
                  },
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Text("Role:  "),
                GestureDetector(
                  onTap: selectRole,
                  child: Text(
                    "patient",
                    style: TextStyle(
                      color: role ? kDark : Theme.of(context).primaryColor,
                      fontWeight: role ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: selectRole,
                  child: Text(
                    "psychologist",
                    style: TextStyle(
                      color: !role ? kDark : Theme.of(context).primaryColor,
                      fontWeight: !role ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<NavigationBloc>().add(
                          SignUpEvent(
                            user: {
                              "name": name,
                              "surname": surname,
                              "email": email,
                              "password": password,
                              "role": !role ? "USR": "PSY",
                            },
                          ),
                        );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      child: Text(
                        "sign up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      context.read<NavigationBloc>().add(GoToLogInScreen());
                    },
                    child: Text("log in"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
