import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../core/const.dart';

class SmallAccountCard extends StatelessWidget {
  SmallAccountCard({
    @required String name,
    @required String role,
    @required String email,
    Function select,
  })  : _name = name,
        _role = role,
        _email = email,
        _select = select;
  final String _name;
  final String _role;
  final String _email;
  final Function _select;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _select,
        child: Container(
          decoration: BoxDecoration(border: kBottomBorder),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                child: ClipOval(
                  child: Image(
                    image: AssetImage("assets/aph.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: kSubtitle,
                  ),
                  Text(
                    _email,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    _role == "USR" ? "patient" : "psychologists",
                    style: TextStyle(
                      fontSize: 13,
                      color: kLightGrayAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
