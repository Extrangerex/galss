import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/home_model/home_model_bloc.dart';
import 'package:galss/blocs/home_model/home_model_event.dart';
import 'package:galss/blocs/home_model/home_model_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/modals/edit_current_location_modal.dart';
import 'package:galss/modals/edit_name_modal.dart';
import 'package:galss/modals/edit_profile_status_modal.dart';
import 'package:galss/models/photo.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/theme/button_styles.dart';
import 'package:galss/theme/variables.dart';
import 'package:image_picker/image_picker.dart';

class HomeModelLanding extends StatelessWidget {
  const HomeModelLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc()..add(const FetchUserData()),
        )
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Flexible(child: _likesCount())],
            )
          ]),
        ),
      ),
    );
  }

  Widget carouselSlider() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        List<Photo> photos = state.user?.photos ?? [];

        return CarouselSlider(
            items: photos
                .map((e) => SizedBox.expand(
                      child: Image.network(
                        "${HttpService.apiBaseUrl}/${e.urlPath!}",
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                height: 200, viewportFraction: 1, enableInfiniteScroll: false));
      },
    );
  }

  Widget _addPhotoBtn() {
    return BlocListener<HomeModelBloc, HomeModelState>(
        listener: (context, state) {
      if (state.fetchStatus is ApiFetchSuccededStatus) {
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

  Widget _editProfileBtn({required BuildContext context}) => ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(holoGreenDark),
          textStyle:
              MaterialStateProperty.all(const TextStyle(color: Colors.white))),
      onPressed: () {},
      child: Text(S.current.editar_mi_perfil));

  Widget _connectionsBtn({required BuildContext context}) => ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).primaryColor),
          textStyle:
              MaterialStateProperty.all(const TextStyle(color: Colors.white))),
      onPressed: () {},
      child: Text(S.current.my_connections));

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

        return Card(
          child: ListTile(

            // tileColor: Theme.of(context).primaryColor,
              title: Text(likesCount.toString()),
              leading: const Icon(FontAwesomeIcons.heart)),
        );
      },
    );
  }

  // Widget _favCount() {
  //   return BlocBuilder<UserBloc, UserState>(
  //     builder: (context, state) {
  //       var likesCount = state.user;
  //
  //       return Card(
  //         child: ListTile(
  //
  //           // tileColor: Theme.of(context).primaryColor,
  //             title: Text(likesCount.toString()),
  //             leading: const Icon(FontAwesomeIcons.heart)),
  //       );
  //     },
  //   );
  // }

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
