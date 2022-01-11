import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/drawer/drawer_event.dart';
import 'package:galss/blocs/drawer/drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerState()) {
    on<DrawerWidgetChangedEvent>((event, emit) => emit(state.copyWith(
        drawerIndex: event.newIndex, drawerWidget: event.newWidget)));
  }
}
