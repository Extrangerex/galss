import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/home_model/home_model_event.dart';
import 'package:galss/blocs/home_model/home_model_state.dart';

class HomeModelBloc extends Bloc<HomeModelEvent, HomeModelState> {
  HomeModelBloc() : super(HomeModelState()) {
    on<HomeModelDrawerWidgetChangedEvent>((event, emit) => emit(state.copyWith(
        drawerIndex: event.newIndex, drawerWidget: event.newWidget)));
  }
}
