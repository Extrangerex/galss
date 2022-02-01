import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/models/user.dart';
import 'package:galss/pages/model_viewer_profile.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/images.dart';

class RecentlyAddedModels extends StatelessWidget {
  const RecentlyAddedModels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
      create: (create) => HomeSeekerCatalogBloc()
        ..add(const HomeSeekerGetRecentlyAddedModelsEvent()),
      child: BlocBuilder<HomeSeekerCatalogBloc, HomeSeekerCatalogState>(
          builder: (context, state) {
        if (state.models.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              color: Colors.pink.shade100,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                S.current.recently_added,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.pink.shade900),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: state.models
                    .map((e) => InkWell(
                        onTap: () {
                          locator<NavigationService>()
                              .navigatorKey
                              .currentState
                              ?.push(MaterialPageRoute(
                                  builder: (builder) =>
                                      ModelViewerProfile(userModel: e)));
                        },
                        child: modelCard(e)))
                    .toList(),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget modelCard(User user) {
    return SizedBox(
      height: 180,
      width: 180,
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: CachedNetworkImage(
                imageUrl:
                    "${HttpService.apiBaseUrl}/${user.profilePhoto?.urlPath}",
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    Image(image: placeHolderProfileImg),
              )),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black87,
                child: ListTile(
                  title: Text("${user.model?.fullName}"),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${user.currentLocation?.name}"),
                      Text("${user.country?.name}"),
                    ],
                  ),
                  isThreeLine: true,
                ),
              ),
            ),
            // bottom: 0,
          )
        ],
      ),
    );
  }
}
