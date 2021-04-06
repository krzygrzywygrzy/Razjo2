import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razjo/core/erros/failures.dart';

import '../../../core/const.dart';
import '../../../widgets/form_input.dart';
import '../../bloc/navigation_bloc.dart';

class SignUpPage extends StatefulWidget {
  final Failure failure;

  const SignUpPage({Key key, this.failure}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name, surname, email, password, title = "Sign Up";
  bool role = false;

  void selectRole() {
    setState(() {
      role = !role;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.failure != null) {
      if (widget.failure is ConnectionFailure)
        title = "Connection Error, try again!";
      else if (widget.failure is SignUpFailure)
        title = "Wrong Data, try again!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
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
                              "role": !role ? "USR" : "PSY",
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
