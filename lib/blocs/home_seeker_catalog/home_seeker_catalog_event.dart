import 'package:galss/models/user.dart';

abstract class HomeSeekerCatalogEvent {
  const HomeSeekerCatalogEvent();
}

class HomeSeekerCatalogGetModelsEvent extends HomeSeekerCatalogEvent {
  const HomeSeekerCatalogGetModelsEvent();
}

class HomeSeekerGetCloseMeEvent extends HomeSeekerCatalogEvent {
  const HomeSeekerGetCloseMeEvent();
}

class HomeSeekerGetFavoritesEvent extends HomeSeekerCatalogEvent {
  const HomeSeekerGetFavoritesEvent();
}

class HomeSeekerGetLikedModelsEvent extends HomeSeekerCatalogEvent {
  const HomeSeekerGetLikedModelsEvent();
}

class HomeSeekerGetRecentlyAddedModelsEvent extends HomeSeekerCatalogEvent {
  const HomeSeekerGetRecentlyAddedModelsEvent();
}

class HomeSeekerSearchFieldChanged extends HomeSeekerCatalogEvent {
  final String q;

  const HomeSeekerSearchFieldChanged({required this.q});
}

class HomeSeekerLikeModelClicked extends HomeSeekerCatalogEvent {
  final User model;
  final bool isLiked;

  const HomeSeekerLikeModelClicked(
      {required this.model, required this.isLiked});
}

class HomeSeekerFavModelClicked extends HomeSeekerCatalogEvent {
  final User model;
  final bool isFavorite;

  const HomeSeekerFavModelClicked(
      {required this.model, required this.isFavorite});
}
