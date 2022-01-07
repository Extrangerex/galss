import 'package:flutter/cupertino.dart';
import 'package:galss/pages/model/home_model_landing.dart';

class HomeModelState {
  final Widget? drawerWidget;
  final int? drawerIndex;

  HomeModelState(
      {this.drawerIndex = 0, this.drawerWidget = const HomeModelLanding()});

  HomeModelState copyWith({Widget? drawerWidget, int? drawerIndex}) =>
      HomeModelState(
          drawerIndex: drawerIndex ?? this.drawerIndex,
          drawerWidget: drawerWidget ?? this.drawerWidget);
}
