import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState()) {
    on<DrawerWidgetChangedEvent>((event, emit) => emit(state.copyWith(
        navigationIndex: event.newIndex, navigationWidget: event.newWidget)));
  }
}
