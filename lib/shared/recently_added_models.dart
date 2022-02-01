import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_bloc.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_event.dart';
import 'package:galss/blocs/home_seeker_catalog/home_seeker_catalog_state.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/shared/images.dart';

class RecentlyAddedModelCard extends StatelessWidget {
  final User model;

  const RecentlyAddedModelCard({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return modelCard(model);
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
                errorWidget: (context, url, error) =>
                    Image(image: placeHolderProfileImg),
              )),
          Positioned(
            child: ListTile(
              title: Text("${user.model?.fullName}"),
              subtitle: Column(
                children: [
                  Text("${user.currentLocation?.name}"),
                  Text("${user.country?.name}"),
                ],
              ),
              isThreeLine: true,
            ),
            bottom: 0,
          )
        ],
      ),
    );
  }
}
