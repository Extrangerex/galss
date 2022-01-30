import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_event.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/models/photo.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/http_service.dart';

class ModelViewerProfile extends StatefulWidget {
  final User userModel;

  const ModelViewerProfile({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ModelViewerProfileState();
}

class _ModelViewerProfileState extends State<ModelViewerProfile> {
  Color backgroundColor = const Color.fromRGBO(243, 235, 241, 1);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (create) => CountryBloc()
              ..add(FetchListCities(countryId: widget.userModel.country!.id!))),
        BlocProvider(
            create: (create) =>
                UserBloc()..add(FetchUserData(userId: widget.userModel.id)))
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text("${widget.userModel.model!.fullName}"),
        ),
        body: ListView(
          children: [
            carouselSlider(),
            const SizedBox(
              height: 30,
            ),
            ListTile(
              title: text(
                  "${widget.userModel.model?.fullName}, ${widget.userModel.age}",
                  color: Colors.black),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text("${widget.userModel.country?.name}",
                      color: Colors.black),
                  city()
                ],
              ),
              isThreeLine: true,
            ),
            ListTile(
                leading: Icon(
                  Icons.location_on_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "${widget.userModel.currentLocation?.name}",
                  style: const TextStyle(color: Colors.black),
                )),
            ListTile(
                leading: Icon(
                  FontAwesomeIcons.rocketchat,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "${widget.userModel.profileStatus}",
                  style: const TextStyle(color: Colors.black),
                )),
            Theme(
              data: Theme.of(context).copyWith(
                  iconTheme:
                      IconThemeData(color: Theme.of(context).primaryColor)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      iconSize: 34,
                      icon: const Icon(FontAwesomeIcons.heart)),
                  IconButton(
                      onPressed: () {},
                      iconSize: 34,
                      icon: const Icon(FontAwesomeIcons.star)),
                  IconButton(
                      onPressed: () {},
                      iconSize: 34,
                      icon: const Icon(Icons.chat)),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: likesCount(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget text(String data, {Color? color, double? fontSize}) {
    return Text(
      data,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }

  Widget city() {
    return Theme(
      data: ThemeData.light(),
      child: BlocBuilder<CountryBloc, CountryState>(builder: (context, state) {
        var cityId = widget.userModel.model?.city;

        if (state.cities.isEmpty || cityId == null) {
          return Text(
            S.current.unknown_city,
            style: Theme.of(context).textTheme.caption,
          );
        }

        return Text("${state.findCityById(cityId).name}",
            style: Theme.of(context).textTheme.caption);
      }),
    );
  }

  Widget likesCount() {
    var likesCount = widget.userModel.model?.likesCount ?? 0;

    return text("${S.current.liked_by_n_people(likesCount)}",
        color: Colors.black);
  }

  Widget carouselSlider() {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      var photos = state.user?.photos ?? [];

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
              height: 300, viewportFraction: 1, enableInfiniteScroll: false));
    });
  }
}
