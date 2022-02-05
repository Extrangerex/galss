import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/pages/seeker/shared_widgets/model_catalog_list_item.dart';

class HomeSeekerLikes extends StatelessWidget {
  const HomeSeekerLikes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(S.current.your_likes),
        ),
        body: BlocProvider(
          create: (create) => HomeSeekerCatalogBloc()
            ..add(const HomeSeekerGetLikedModelsEvent()),
          child: BlocBuilder<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
              builder: (context, state) {
            return ListView.builder(
              itemCount: state.likes.length,
              itemBuilder: (context, index) {
                final item = state.likes[index];

                return ModelCatalogListItem(userModel: item.user!);
              },
            );
          }),
        ));
  }
}
