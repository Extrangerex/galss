import 'package:galss/api_fetch_status.dart';
import 'package:galss/models/api_user_favorite.dart';
import 'package:galss/models/api_user_like.dart';
import 'package:galss/models/user.dart';

class HomeSeekerCatalogState {
  final List<User> models;
  final List<UserFavorite> favorites;
  final List<UserLike> likes;
  final ApiFetchStatus fetchModelStatus;
  final ApiFetchStatus requestToggleModelStatus;

  const HomeSeekerCatalogState(
      {this.models = const [],
      this.favorites = const [],
      this.likes = const [],
      this.requestToggleModelStatus = const ApiFetchInitialStatus(),
      this.fetchModelStatus = const ApiFetchInitialStatus()});

  HomeSeekerCatalogState copyWith(
          {List<User>? models,
          List<UserFavorite>? favorites,
          List<UserLike>? likes,
          ApiFetchStatus? fetchModelStatus,
          ApiFetchStatus? requestToggleModelStatus}) =>
      HomeSeekerCatalogState(
          fetchModelStatus: fetchModelStatus ?? this.fetchModelStatus,
          requestToggleModelStatus:
              requestToggleModelStatus ?? this.requestToggleModelStatus,
          models: models ?? this.models,
          likes: likes ?? this.likes,
          favorites: favorites ?? this.favorites);
}
