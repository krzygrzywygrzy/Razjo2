import 'package:flutter/material.dart';
import 'package:razjo/routes/bloc/navigation_bloc.dart';
import 'package:razjo/widgets/form_input.dart';

class LogInPage extends StatelessWidget {
  String login;
  String password;

  void submit (BuildContext context){
    //TODO: add event to the stream
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            onTap: (){
              submit(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top:8),
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
                      onTap: (){
                        print("go to sign up page");
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
    );
  }
}
