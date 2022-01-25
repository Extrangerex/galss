import 'package:galss/models/user.dart';

abstract class HomeSeekerCatalogEvent {
  const HomeSeekerCatalogEvent();
}

class HomeSeekerCatalogGetModelsEvent extends HomeSeekerCatalogEvent {
  const HomeSeekerCatalogGetModelsEvent();
}

class HomeSeekerFavModelClicked extends HomeSeekerCatalogEvent {
  final User model;
  final bool isFavorite;

  const HomeSeekerFavModelClicked({required this.model, required this.isFavorite});
}