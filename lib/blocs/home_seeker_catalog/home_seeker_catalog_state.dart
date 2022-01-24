import 'package:galss/api_fetch_status.dart';
import 'package:galss/models/user.dart';

class HomeSeekerCatalogState {
  final List<User> models;
  final ApiFetchStatus fetchModelStatus;

  const HomeSeekerCatalogState(
      {this.models = const [],
      this.fetchModelStatus = const ApiFetchInitialStatus()});

  HomeSeekerCatalogState copyWith(
          {List<User>? models, ApiFetchStatus? fetchModelStatus}) =>
      HomeSeekerCatalogState(
          fetchModelStatus: fetchModelStatus ?? this.fetchModelStatus,
          models: models ?? this.models);
}
