import 'package:flutter/cupertino.dart';

abstract class HomeModelEvent {
  const HomeModelEvent();
}

class HomeModelDrawerWidgetChangedEvent extends HomeModelEvent {
  final Widget newWidget;
  final int newIndex;

  const HomeModelDrawerWidgetChangedEvent(
      {required this.newIndex, required this.newWidget});
}
