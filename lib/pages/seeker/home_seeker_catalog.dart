import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/pages/model_viewer_profile.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/images.dart';
import 'package:galss/shared/recently_added_models.dart';
import 'package:galss/shared/toggle_like_model.dart';

class HomeSeekerCatalog extends StatefulWidget {
  const HomeSeekerCatalog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSeekerCatalogState();
}

class _HomeSeekerCatalogState extends State<HomeSeekerCatalog> {
  TextEditingController searchTextEditingController = TextEditingController();
  Color backgroundColor = const Color.fromRGBO(243, 235, 241, 1);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (create) => UserBloc()..add(const FetchUserData())),
        BlocProvider(
          create: (create) => HomeSeekerCatalogBloc()
            ..add(const HomeSeekerCatalogGetModelsEvent()),
        )
      ],
      child: Theme(
        data: ThemeData.light(),
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: _searchTextField(),
            ),
            titleSpacing: 8,
          ),
          body: SingleChildScrollView(
            primary: true,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Theme(
                    data: ThemeData.dark(), child: const RecentlyAddedModels()),
                _models(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return BlocBuilder<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
      builder: (context, state) => TextField(
        controller: searchTextEditingController,
        onChanged: (v) {
          if (v == "") {
            context
                .read<HomeSeekerCatalogBloc>()
                .add(const HomeSeekerCatalogGetModelsEvent());
            return;
          }

          context
              .read<HomeSeekerCatalogBloc>()
              .add(HomeSeekerSearchFieldChanged(q: v));
        },
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: searchTextEditingController.text != ""
                  ? const Icon(Icons.clear)
                  : const SizedBox.shrink(),
              onPressed: () {
                /* Clear the search field */
                searchTextEditingController.text = "";
                context
                    .read<HomeSeekerCatalogBloc>()
                    .add(const HomeSeekerSearchFieldChanged(q: ""));
              },
            ),
            hintText: S.current.search,
            border: InputBorder.none),
      ),
    );
  }

  Widget _models() {
    return BlocBuilder<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
        builder: (context, state) => ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: state.models.length,
              itemBuilder: (context, index) {
                var item = state.models[index];

                return InkWell(
                  onTap: () {
                    locator<NavigationService>()
                        .navigatorKey
                        .currentState
                        ?.push(MaterialPageRoute(
                            builder: (builder) =>
                                ModelViewerProfile(userModel: item)));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(width: .25))),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            constraints: const BoxConstraints(minHeight: 128),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${HttpService.apiBaseUrl}/${item.profilePhoto?.urlPath}",
                              fit: BoxFit.cover,
                              height: 128,
                              errorWidget: (context, url, error) => Image(
                                image: profilePlaceholderImage,
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
                            trailing: ToggleLikeModel(model: item),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
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
                    ),
                  ),
                );
              },
            ));
  }
}
