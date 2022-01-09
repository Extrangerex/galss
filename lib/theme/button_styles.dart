import 'package:flutter/material.dart';
import 'package:galss/theme/variables.dart';

ButtonStyle holoGreenDarkBtnStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(holoGreenDark),
    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)));

ButtonStyle grayBtnStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(defaultGray),
    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)));

EdgeInsets paddingBtnLg =
    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0);
