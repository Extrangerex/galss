import 'package:flutter/material.dart';

abstract class NavigationEvent {
  const NavigationEvent();
}

class DrawerWidgetChangedEvent extends NavigationEvent {
  final Widget newWidget;
  final int newIndex;

  const DrawerWidgetChangedEvent(
      {required this.newIndex, required this.newWidget});
}
