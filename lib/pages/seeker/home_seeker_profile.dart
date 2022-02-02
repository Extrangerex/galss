import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_event.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/shared/images.dart';

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
          body: Column(
            children: [
              profilePhoto(),
              const SizedBox(
                height: 10,
              ),
              displayName(),
              userData(),
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
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    Text(state.user?.currentLocation?.name ??
                        S.current.not_specified)
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.chat_bubble,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    Text(state.user?.profileStatus ?? S.current.not_specified)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget editProfileBtn() {
    return ElevatedButton(
        onPressed: () {}, child: Text(S.current.edit_profile));
  }

  //
  // Widget city() {
  //   return BlocBuilder<UserBloc, UserState>(
  //     builder: (context, userState) => BlocProvider(
  //       create: (create) => CountryBloc()
  //         ..add(FetchListCities(countryId: userState.user!.country!.id!)),
  //       child:
  //           BlocBuilder<CountryBloc, CountryState>(builder: (context, state) {
  //         var cityId = userState.user?.seeker?.city;
  //
  //         if (state.cities == null) {
  //           return Text(S.current.unknown_city);
  //         }
  //
  //         if (state.cities.isEmpty || cityId == null) {
  //           return Text(
  //             S.current.unknown_city,
  //             style: Theme.of(context).textTheme.caption,
  //           );
  //         }
  //
  //         return Text("${state.findCityById(cityId).name}",
  //             style: Theme.of(context).textTheme.caption);
  //       }),
  //     ),
  //   );
  // }

  Widget userData() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Center(
            child: Column(
              children: [
                // city(),
                Text("${state.user?.country?.name}"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget displayName() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: Text("${state.user?.fullName}"));
      },
    );
  }

  Widget profilePhoto() {
    double imgRadius = 64;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
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
          ),
        );
      },
    );
  }
}
