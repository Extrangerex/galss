import 'package:flutter/material.dart';
import 'package:galss/theme/variables.dart';

ButtonStyle primaryColorBtnStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(primaryColor),
    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)));

ButtonStyle holoGreenDarkBtnStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(holoGreenDark),
    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)));

ButtonStyle grayBtnStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(defaultGray),
    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)));

ButtonStyle btnLgStyle = ButtonStyle(
  textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 20)),
);
