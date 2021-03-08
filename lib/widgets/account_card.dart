import 'package:flutter/material.dart';
import 'package:razjo/core/const.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    Key key,
    this.name,
    this.surname,
    this.role,
  }) : super(key: key);

  final String name;
  final String surname;
  final String role;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: _size.width < 1500 ? 60 : 80,
                width: _size.width < 1500 ? 60 : 80,
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
                '$name $surname',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: kDark,
                ),
              ),
              Text(
                role == "PSY" ? 'psychologist' : "patient",
                style: TextStyle(color: kLightGrayAccent),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
