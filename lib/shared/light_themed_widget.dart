import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightThemedWidget extends StatelessWidget {
  final Widget child;

  const LightThemedWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Theme(data: ThemeData.light(), child: child);
  }
}
