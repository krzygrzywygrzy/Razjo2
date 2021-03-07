import 'package:flutter/material.dart';
import 'package:razjo/routes/bloc/navigation_bloc.dart';
import 'package:razjo/widgets/form_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInPage extends StatelessWidget {
  String login;
  String password;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        SizedBox(
          width: _width > 420 ? 100: 0,
        ),
        Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          crossAxisAlignment: _width > 420? CrossAxisAlignment.start: CrossAxisAlignment.center,
          children: [
            Text(
              "Razjo",
              style: TextStyle(fontSize: 30),
            ),
            FormInput(
              hint: "login",
              onChange: (value) {
                login = value;
              },
            ),
            FormInput(
              hint: "password",
              onChange: (value) {
                password = value;
              },
            ),
            GestureDetector(
              onTap: () {
                context
                    .read<NavigationBloc>()
                    .add(LogInEvent(login: login, password: password));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Container(
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
                          "log in",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<NavigationBloc>().add(GoToSignUpScreen());
                        },
                        child: Text("sign up"),
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