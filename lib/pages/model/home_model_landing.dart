import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/chats/chat_bloc.dart';
import 'package:galss/blocs/chats/chat_event.dart';
import 'package:galss/blocs/chats/chat_state.dart';
import 'package:galss/blocs/home_model/home_model_bloc.dart';
import 'package:galss/blocs/home_model/home_model_event.dart';
import 'package:galss/blocs/home_model/home_model_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/modals/edit_current_location_modal.dart';
import 'package:galss/modals/edit_name_modal.dart';
import 'package:galss/modals/edit_profile_status_modal.dart';
import 'package:galss/models/photo.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/carousel_with_indicators.dart';
import 'package:galss/shared/full_screen_image.dart';
import 'package:galss/theme/button_styles.dart';
import 'package:galss/theme/variables.dart';
import 'package:image_picker/image_picker.dart';

import 'home_model_connections.dart';

class HomeModelLanding extends StatelessWidget {
  const HomeModelLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc()..add(const FetchUserData()),
        ),
        BlocProvider(
            create: (create) => ChatBloc()..add(const ChatGetChatsEvent()))
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              carouselSlider(),
              Column(
                children: [
                  _addPhotoBtn(),
                ],
              ),
              _nameTile(),
              _locationTile(),
              _nationalityTile(),
              _description(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: _likesCount()),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(child: chatCount())
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget carouselSlider() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        List<Photo> photos = state.user?.photos ?? [];

        return CarouselWithIndicator(
            items: photos
                .map((e) => GestureDetector(
                      onTap: () {
                        locator<NavigationService>()
                            .navigatorKey
                            .currentState
                            ?.push(MaterialPageRoute(builder: (_) {
                          return FullScreenImage(
                            imageUrl: "${HttpService.apiBaseUrl}/${e.urlPath!}",
                            tag: e.fileName.toString(),
                          );
                        }));
                      },
                      child: Hero(
                        tag: e.fileName.toString(),
                        child: SizedBox.expand(
                          child: Image.network(
                            "${HttpService.apiBaseUrl}/${e.urlPath!}",
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                viewportFraction: 1, enableInfiniteScroll: false));
      },
    );
  }

  Widget chatCount() {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final chatCount = state.rooms.length;

        return InkWell(
          onTap: () {
            locator<NavigationService>().navigatorKey.currentState?.push(
                MaterialPageRoute(
                    builder: (builder) => const HomeModelConnections()));
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.chat,
                  size: 32,
                ),
              ),
              Text(chatCount.toString())
            ],
          ),
        );
      },
    );
  }

  Widget _addPhotoBtn() {
    return BlocListener<HomeModelBloc, HomeModelState>(
        listener: (context, state) {
      if (state.fetchStatus is ApiFetchSucceededStatus) {
        context.read<UserBloc>().add(const FetchUserData());
      }
    }, child: BlocBuilder<HomeModelBloc, HomeModelState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton.icon(
              onPressed: () async {
                final picker = ImagePicker();
                final imageFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (imageFile != null) {
                  context.read<HomeModelBloc>().add(
                      HomeModelUploadImageEvent(imageFileToUpload: imageFile));
                }
              },
              style: primaryColorBtnStyle,
              icon: const FaIcon(FontAwesomeIcons.camera),
              label: Text(S.current.add_photo)),
        );
      },
    ));
  }

  Widget _nameTile() => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          handleNameChange() {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (builder) => const EditNameModal()).then((_) {
              context.read<UserBloc>().add(const FetchUserData());
            });
          }

          var name = state.user?.model?.fullName ?? "";
          return ListTile(
            title: Text(S.current.name),
            subtitle: Text(name),
            trailing: const Icon(Icons.edit),
            onTap: () => handleNameChange(),
          );
        },
      );

  Widget _locationTile() => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          handleEditCurrentLocation() {
            showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (builder) =>
                        EditCurrentLocationModal(country: state.user!.country!))
                .then((_) {
              context.read<UserBloc>().add(const FetchUserData());
            });
          }

          var name = state.user?.currentLocation?.name ?? "";
          return ListTile(
            title: Text(S.current.current_location),
            subtitle: Text(name),
            trailing: const Icon(Icons.edit),
            onTap: () => handleEditCurrentLocation(),
          );
        },
      );

  Widget _nationalityTile() => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          var name = state.user?.country?.name ?? "";
          return ListTile(
              title: Text(S.current.nationality), subtitle: Text(name));
        },
      );

  Widget _likesCount() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        var likesCount = state.user?.model?.likesCount ?? 0;

        return InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (builder) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(S.current.n_people_liked_you(likesCount))),
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  FontAwesomeIcons.heart,
                  size: 32,
                ),
              ),
              Text(likesCount.toString())
            ],
          ),
        );
      },
    );
  }

  Widget _description() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        var profileStatus = state.user?.profileStatus ?? "";

        handleDescriptionChange() {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (builder) => const EditProfileStatusModal()).then((_) {
            context.read<UserBloc>().add(const FetchUserData());
          });
        }

        return ListTile(
          // tileColor: Theme.of(context).primaryColor,
          title: Text(S.current.profile_status),
          subtitle: Text(profileStatus),
          trailing: const Icon(Icons.edit),
          onTap: () => handleDescriptionChange(),
        );
      },
    );
  }
}
