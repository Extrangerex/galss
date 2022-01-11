import 'package:flutter/material.dart';

abstract class DrawerEvent {
  const DrawerEvent();
}

class DrawerWidgetChangedEvent extends DrawerEvent {
  final Widget newWidget;
  final int newIndex;

  const DrawerWidgetChangedEvent(
      {required this.newIndex, required this.newWidget});
}
