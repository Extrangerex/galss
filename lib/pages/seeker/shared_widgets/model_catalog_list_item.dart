

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/images.dart';
import 'package:galss/shared/toggle_like_model.dart';

import '../../../main.dart';
import '../../model_viewer_profile.dart';

class ModelCatalogListItem extends StatelessWidget{
  final User userModel;

  const ModelCatalogListItem({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        locator<NavigationService>()
            .navigatorKey
            .currentState
            ?.push(MaterialPageRoute(
            builder: (builder) =>
                ModelViewerProfile(userModel: userModel)));
      },
      child: Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: .25)
            )
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 128),
                child: CachedNetworkImage(
                  imageUrl:
                  "${HttpService.apiBaseUrl}/${userModel.profilePhoto?.urlPath}",
                  fit: BoxFit.cover,
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
                title: Text("${userModel.model?.fullName}"),
                isThreeLine: true,
                trailing: ToggleLikeModel(model: userModel),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${userModel.currentLocation?.name}"),
                    Text("${userModel.country?.name}"),
                    Text(
                      "${userModel.profileStatus}",
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
  }
}