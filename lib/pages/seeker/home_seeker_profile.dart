import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/modals/edit_current_location_modal.dart';
import 'package:galss/modals/edit_name_modal.dart';
import 'package:galss/modals/edit_profile_status_modal.dart';
import 'package:galss/models/country.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/shared/images.dart';
import 'package:image_picker/image_picker.dart';

class HomeSeekerProfile extends StatefulWidget {
  const HomeSeekerProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeSeekerProfileState();
}

class _HomeSeekerProfileState extends State<HomeSeekerProfile> {
  Color backgroundColor = const Color.fromRGBO(243, 235, 241, 1);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (create) => UserBloc()..add(const FetchUserData()))
      ],
      child: Theme(
        data: ThemeData.light(),
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: ListView(
            children: [
              profilePhoto(),
              const SizedBox(
                height: 10,
              ),
              displayName(),
              profileStatusText(),
              userData(),
              switchAnonymous(),
            ],
          ),
        ),
      ),
    );
  }

  Widget dateOfInterest() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Center(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  title: Text(S.current.current_location),
                  subtitle: Text(state.user?.currentLocation?.name ??
                      S.current.not_specified),
                ),
                ListTile(
                    leading: Icon(
                      Icons.chat_bubble,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    title: Text(S.current.profile_status),
                    subtitle: Text(
                        state.user?.profileStatus ?? S.current.not_specified))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget switchAnonymous() {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.actionFetchStatus is ApiFetchSucceededStatus) {
          context.read<UserBloc>().add(const FetchUserData());
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          var isAnonymous = state.user?.anonymous ?? false;

          return SwitchListTile(
            value: isAnonymous,
            onChanged: (value) {
              context
                  .read<UserBloc>()
                  .add(UserAnonymousChanged(anonymous: value));
            },
            title: Text(S.current.switch_anonymous_mode),
          );
        },
      ),
    );
  }

  Widget profileStatusText() {
    handleEditProfileStatus(BuildContext context) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (builder) => const EditProfileStatusModal()).then((_) {
        context.read<UserBloc>().add(const FetchUserData());
      });
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return ListTile(
          onTap: () {
            handleEditProfileStatus(context);
          },
          title: Text(S.current.profile_status),
          subtitle: Text(state.user?.profileStatus ?? S.current.not_specified),
          trailing: const Icon(Icons.edit),
        );
      },
    );
  }

  Widget userData() {
    handleEditCurrentLocation(BuildContext context, Country country) {
      showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (builder) => EditCurrentLocationModal(country: country))
          .then((_) {
        context.read<UserBloc>().add(const FetchUserData());
      });
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return SizedBox(
          child: Center(
            child: Column(
              children: [
                ListTile(
                  title: Text(S.current.current_location),
                  subtitle: Text(state.user?.currentLocation?.name ??
                      S.current.not_specified),
                  trailing: const Icon(Icons.edit),
                  onTap: () {
                    handleEditCurrentLocation(context, state.user!.country!);
                  },
                ),
                ListTile(
                  title: Text(S.current.country),
                  subtitle: Text("${state.user?.country?.name}"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget displayName() {
    handleEditNameBtn(BuildContext context) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (builder) => const EditNameModal()).then((_) {
        context.read<UserBloc>().add(const FetchUserData());
      });
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return ListTile(
            onTap: () => handleEditNameBtn(context),
            trailing: const Icon(Icons.edit),
            title: Text(S.current.name),
            subtitle: Text("${state.user?.fullName}"));
      },
    );
  }

  Widget profilePhoto() {
    double imgRadius = 64;

    handleUploadPhoto(BuildContext context) async {
      final picker = ImagePicker();
      final imageFile = await picker.pickImage(source: ImageSource.gallery);

      if (imageFile != null) {
        context
            .read<UserBloc>()
            .add(UserProfilePhotoChanged(imageToUpload: imageFile));
      }
    }

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state.actionFetchStatus is ApiFetchSucceededStatus) {
          context.read<UserBloc>().add(const FetchUserData());
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                      radius: imgRadius,
                    ),
                    imageUrl:
                        "${HttpService.apiBaseUrl}/${state.user?.profilePhoto?.urlPath}",
                    errorWidget: (context, url, error) => CircleAvatar(
                      backgroundImage: profilePlaceholderImage,
                      radius: imgRadius,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () => handleUploadPhoto(context),
                      child: Text(S.current.add_photo))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
