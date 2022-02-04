import 'package:flutter/material.dart';

class NavigationState {
  final Widget? navigationWidget;
  final int navigationIndex;

  NavigationState({this.navigationIndex = 0, this.navigationWidget});

  NavigationState copyWith({Widget? navigationWidget, int? navigationIndex}) =>
      NavigationState(
          navigationIndex: navigationIndex ?? this.navigationIndex,
          navigationWidget: navigationWidget ?? this.navigationWidget);
}
