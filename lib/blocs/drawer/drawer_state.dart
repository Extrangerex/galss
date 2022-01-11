import 'package:flutter/material.dart';

class DrawerState {
  final Widget? drawerWidget;
  final int drawerIndex;

  DrawerState({this.drawerIndex = 0, this.drawerWidget});

  DrawerState copyWith({Widget? drawerWidget, int? drawerIndex}) => DrawerState(
      drawerIndex: drawerIndex ?? this.drawerIndex,
      drawerWidget: drawerWidget ?? this.drawerWidget);
}
