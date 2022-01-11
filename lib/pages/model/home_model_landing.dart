import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/models/photo.dart';
import 'package:galss/theme/variables.dart';

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
          child: ListView(
            children: [
              carouselSlider(),
              _nameTile(),
              _locationTile(),
              _nationalityTile(),
              // Row(
              //   children: [_nameTile(), _locationTile()],
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [_nationalityTile()],
              // ),
              _description(),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: _editProfileBtn(context: context)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(child: _connectionsBtn(context: context))
                ],
              )
            ],
          ),
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
                .map((e) => Center(
                      child: Image.network(
                        e.urlPath!,
                        fit: BoxFit.cover,
                      ),
                    ))
                .toList(),
            options: CarouselOptions(height: 200));
      },
    );
  }

  Widget _listTile({required String title, required String subtitle}) =>
      ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      );

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
          var name = state.user?.model?.fullName ?? "";
          return _listTile(title: S.current.name, subtitle: name);
        },
      );

  Widget _locationTile() => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          var name = state.user?.currentLocation?.name ?? "";
          return _listTile(title: S.current.current_location, subtitle: name);
        },
      );

  Widget _nationalityTile() => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          var name = state.user?.country?.name ?? "";
          return _listTile(title: S.current.nationality, subtitle: name);
        },
      );

  Widget _description() => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          var profileStatus = state.user?.profileStatus ?? "";

          return ListTile(
            tileColor: Theme.of(context).primaryColor,
            title: Text(profileStatus),
          );
        },
      );
}
