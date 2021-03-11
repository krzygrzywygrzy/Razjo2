import 'package:flutter/material.dart';
import 'package:razjo/core/const.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    Key key,
    @required String name,
    @required String surname,
    @required String role,
  })  : _name = name,
        _surname = surname,
        _role = role,
        super(key: key);

  final String _name;
  final String _surname;
  final String _role;

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
                '$_name $_surname',
                style: kSubtitle,
              ),
              Text(
                _role == "PSY" ? 'psychologist' : "patient",
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
