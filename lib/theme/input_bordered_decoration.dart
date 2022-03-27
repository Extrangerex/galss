import 'package:flutter/material.dart';

class InputWhiteFilledBorderedDecoration extends InputDecoration {
  final String? hintText;

  const InputWhiteFilledBorderedDecoration({this.hintText})
      : super(
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText);
}
