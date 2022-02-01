import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/models/api_user_favorite.dart';
import 'package:galss/models/user.dart';
import 'package:galss/theme/variables.dart';

class ToggleFavoriteModel extends StatelessWidget {
  final User model;

  const ToggleFavoriteModel({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return const SizedBox.shrink();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeSeekerCatalogBloc()
              ..add(const HomeSeekerGetFavoritesEvent()))
      ],
      child: BlocListener<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.requestToggleModelStatus is ApiFetchSuccededStatus) {
            context
                .read<HomeSeekerCatalogBloc>()
                .add(const HomeSeekerGetFavoritesEvent());
          }
        },
        child: BlocBuilder<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
          builder: (context, state) {
            var isFavorite = false;

            if (state.favorites.isNotEmpty) {
              isFavorite = state.favorites
                      .singleWhere(
                        (element) => element.user?.id == model.id,
                        orElse: () => UserFavorite(),
                      )
                      .id !=
                  null;
            }

            return IconButton(
                onPressed: () {
                  context.read<HomeSeekerCatalogBloc>().add(
                      HomeSeekerFavModelClicked(
                          model: model, isFavorite: isFavorite));
                },
                icon: FaIcon(
                  FontAwesomeIcons.heart,
                  color: isFavorite ? primaryColor : Colors.black12,
                ));
          },
        ),
      ),
    );
  }
}
