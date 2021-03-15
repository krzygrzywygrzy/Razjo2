import 'package:flutter/material.dart';
import 'package:razjo/core/const.dart';

class DashboardSettingsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration: BoxDecoration(border: kBottomBorder),
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Settings",
                      style: kSubtitle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
