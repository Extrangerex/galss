import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';

class HomeSeekerCatalog extends StatefulWidget {
  const HomeSeekerCatalog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSeekerCatalogState();
}

class _HomeSeekerCatalogState extends State<HomeSeekerCatalog> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (create) => HomeSeekerCatalogBloc()
            ..add(const HomeSeekerCatalogGetModelsEvent()),
        )
      ],
      child: const Scaffold(
        body: Text('data'),
      ),
    );
  }

  Widget _models() {
    return BlocBuilder<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
        builder: (context, state) => ListView.builder(
              itemBuilder: (context, index) {
                var item = state.models[index];

                return ListTile();
              },
            ));
  }
}
