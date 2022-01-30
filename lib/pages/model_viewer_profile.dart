import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_event.dart';
import 'package:galss/blocs/country/country_state.dart';
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (create) => CountryBloc()
              ..add(FetchListCities(countryId: widget.userModel.model!.city!))),
        BlocProvider(
            create: (create) =>
                UserBloc()..add(FetchUserData(userId: widget.userModel.id)))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.userModel.model!.fullName}"),
        ),
        body: ListView(
          children: [
            carouselSlider(),
            const SizedBox(
              height: 30,
            ),
            Text(
                "${widget.userModel.model?.fullName}, ${widget.userModel.age}",
            style: Theme.of(context).textTheme.subtitle1,),
            Text("${widget.userModel.country?.name}"),
            Text("${widget.userModel.currentLocation?.name}"),
            // city(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text("${widget.userModel.profileStatus}")
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget city() {
    return BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) =>
            Text("${state.findCityById(widget.userModel.model!.city!).name}"));
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
