import 'package:flutter/material.dart';
import 'package:galss/main.dart';
import 'package:galss/services/navigation_service.dart';

class DrawerListItem extends StatelessWidget {
  final String label;
  final bool selected;
  final Function() onPressed;

  const DrawerListItem(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      onTap: () {
        onPressed();
        locator<NavigationService>().pop();
      },
    );
  }
}
