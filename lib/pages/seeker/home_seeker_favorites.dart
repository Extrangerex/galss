import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/pages/seeker/shared_widgets/model_catalog_list_item.dart';

class HomeSeekerFavorites extends StatelessWidget {
  const HomeSeekerFavorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(S.current.your_favorites),
        ),
        body: BlocProvider(
          create: (create) =>
              HomeSeekerCatalogBloc()..add(const HomeSeekerGetFavoritesEvent()),
          child: BlocBuilder<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
              builder: (context, state) {
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final item = state.favorites[index];

                return ModelCatalogListItem(userModel: item.user!);
              },
            );
          }),
        ));
  }
}
