import 'package:flutter/material.dart';

const String API_URL = "http://localhost:8080/";
const String MONGO = "mongodb://localhost:27017/razjo";

const SIZE = Size(1035, 600);

const kLightGray = Color(0xffdddddd);
const kLightGrayAccent = Color(0xffcecece);
const kDark = Color(0xff353535);

const kSubtitle = TextStyle(
  color: kDark,
  fontWeight: FontWeight.bold,
);

const kRightBorder = Border(
  right: BorderSide(
    width: 0.5,
    color: kLightGray,
  ),
);

const kBottomBorder = Border(
  bottom: BorderSide(
    width: 0.5,
    color: kLightGray,
  ),
);
