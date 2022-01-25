
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/shared/images.dart';

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
      child: Theme(
        data: ThemeData.light(),
        child: Scaffold(
          appBar: AppBar(),
          body: _models(),
        ),
      ),
    );
  }

  Widget _models() {
    return BlocBuilder<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
        builder: (context, state) => ListView.builder(
              shrinkWrap: true,
              itemCount: state.models.length,
              
              itemBuilder: (context, index) {
                var item = state.models[index];

                return Row(
                  children: [
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 128),
                        child: CachedNetworkImage(
                          imageUrl:
                              "${HttpService.apiBaseUrl}/${item.profilePhoto?.urlPath}",
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image(
                            image: placeHolderProfileImg,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListTile(
                        title: Text("${item.model?.fullName}"),
                        isThreeLine: true,
                        trailing: IconButton(
                            onPressed: () {},
                            icon: const FaIcon(FontAwesomeIcons.heart)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item.currentLocation?.name}"),
                            Text("${item.country?.name}"),
                            Text(
                              "${item.profileStatus}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ));
  }
}
