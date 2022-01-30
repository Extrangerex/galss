import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              ..add(FetchListCities(countryId: widget.userModel.model!.city!)))
      ],
      child: ListView(
        children: [
          carouselSlider(),
          const SizedBox(
            height: 30,
          ),
          Text("${widget.userModel.model?.fullName}, ${widget.userModel.age}"),
          Text("${widget.userModel.model?.city}"),
          city(),
          Text.rich(TextSpan(
            children: [

            ]
          ))
        ],
      ),
    );
  }

  Widget city() {
    return BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) =>
            Text("${state.findCityById(widget.userModel.model!.city!).name}"));
  }

  Widget carouselSlider() {
    List<Photo> photos = widget.userModel.photos ?? [];
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
  }
}

extension IconExt on Text {
  Rich(String text, {required Widget leading, TextStyle? textStyle}) {
    return RichText(
        text: TextSpan(children: [
      WidgetSpan(child: leading),
      TextSpan(text: text, style: textStyle)
    ]));
  }
}
