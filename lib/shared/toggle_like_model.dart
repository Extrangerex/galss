import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/models/api_user_favorite.dart';
import 'package:galss/models/api_user_like.dart';
import 'package:galss/models/user.dart';
import 'package:galss/theme/variables.dart';

class ToggleLikeModel extends StatelessWidget {
  final User model;
  final Function()? afterToggle;

  const ToggleLikeModel({Key? key, required this.model, this.afterToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomeSeekerCatalogBloc()
              ..add(const HomeSeekerGetLikedModelsEvent()))
      ],
      child: BlocListener<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.requestToggleModelStatus is ApiFetchSuccededStatus) {
            context
                .read<HomeSeekerCatalogBloc>()
                .add(const HomeSeekerGetLikedModelsEvent());

            if (afterToggle != null) {
              afterToggle!();
            }
          }
        },
        child: BlocBuilder<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
          builder: (context, state) {
            var isLiked = false;

            if (state.likes.isNotEmpty) {
              isLiked = state.likes
                      .singleWhere(
                        (element) => element.user?.id == model.id,
                        orElse: () => UserLike(),
                      )
                      .id !=
                  null;
            }

            return IconButton(
                onPressed: () {
                  context.read<HomeSeekerCatalogBloc>().add(
                      HomeSeekerLikeModelClicked(
                          model: model, isLiked: isLiked));
                },
                icon: FaIcon(
                  FontAwesomeIcons.solidHeart,
                  color: isLiked ? primaryColor : Colors.black12,
                ));
          },
        ),
      ),
    );
  }
}
