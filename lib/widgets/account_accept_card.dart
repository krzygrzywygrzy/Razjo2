import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:razjo/core/const.dart';
import 'package:razjo/models/user.dart';

class AccountAcceptCard extends StatelessWidget {
  const AccountAcceptCard({
    Key key,
    @required this.user,
    this.accept,
    this.delete,
  }) : super(key: key);

  final User user;
  final Function accept;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 45,
            width: 45,
            child: ClipOval(
              child: Image(
                image: AssetImage("assets/aph.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.name} ${user.surname}',
                  style: kSubtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: accept,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(Icons.check_outlined),
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: delete,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(Icons.clear_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
