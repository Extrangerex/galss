import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/models/photo.dart';
import 'package:galss/services/http_service.dart';

import '../api_fetch_status.dart';
import '../blocs/auth/user_events.dart';
import '../blocs/auth/user_state.dart';
import '../services/navigation_service.dart';
import '../services/snackbar_service.dart';

class RemovableFullScreenImage extends StatelessWidget {
  final Photo photo;
  final String tag;
  final Function? onDeleted;

  const RemovableFullScreenImage(
      {Key? key, required this.photo, required this.tag, this.onDeleted})
      : super(key: key);

  String get imgUrl => "${HttpService.apiBaseUrl}/${photo.urlPath!}";

  handleDeleteButton(BuildContext context) {
    final alertDialog = AlertDialog(
        title: Text(S.current.delete_photo),
        content: Text(S.current.prompt_delete_photo),
        actions: [
          TextButton(
              onPressed: () {
                context.read<UserBloc>().add(UserPhotoDeleted(photo: photo));
              },
              child: Text(S.current.yes)),
          TextButton(
              onPressed: () {
                locator<NavigationService>().pop();
              },
              child: Text(S.current.cancel)),
        ]);

    showDialog(context: context, builder: (builder) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(const FetchUserData()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [deleteButton()],
        ),
        backgroundColor: Colors.black87,
        body: GestureDetector(
          child: SizedBox.expand(
            child: Hero(
              tag: tag,
              child: InteractiveViewer(
                panEnabled: false,
                maxScale: 3,
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  imageUrl: imgUrl,
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget deleteButton() {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.actionFetchStatus is ApiFetchSucceededStatus) {
          locator<SnackbarService>().showMessage(S.current.photo_deleted);
          locator<NavigationService>().pushRemoveUntil('/');
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return IconButton(
              onPressed: () {
                handleDeleteButton(context);
              },
              icon: const Icon(Icons.delete));
        },
      ),
    );
  }
}
