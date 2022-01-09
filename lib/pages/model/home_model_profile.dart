import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_event.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/models/country.dart';
import 'package:galss/models/user.dart';

class HomeModelProfile extends StatefulWidget {
  const HomeModelProfile({Key? key}) : super(key: key);

  @override
  _HomeModelProfileState createState() => _HomeModelProfileState();
}

class _HomeModelProfileState extends State<HomeModelProfile> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UserBloc()..add(const FetchUserData())),
        BlocProvider(
            create: (context) =>
                CountryBloc(CountryState())..add(const FetchListCountry()))
      ],
      child: Scaffold(
        body: ListView(
          children: [],
        ),
      ),
    );
  }

  Widget _profileStatusField() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) => state.copyWith(
              user: state.user?.copyWith({"profileStatus": value})),
        );
      },
    );
  }

  Widget _countryField() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Theme(
          data: ThemeData(brightness: Brightness.light),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.current.country),
              DropdownButton<Country>(
                  items: context
                      .read<CountryBloc>()
                      .state
                      .countries
                      .map((e) =>
                          DropdownMenuItem<Country>(child: Text(e.name!)))
                      .toList(),
                  // underline: const SizedBox.shrink(),
                  isExpanded: true,
                  onChanged: (v) {
                    if (v == null) return;
                    // context
                    //     .read<SignUpBloc>()
                    //     .add(SignUpCountryChanged(country: v));
                  }),
            ],
          ),
        );
      },
    );
  }

  Widget _nameField() {
    // return BlocBuilder<UserBloc, UserState>(
    //   builder: (context, state) {
    //     return TextField(
    //       onChanged: (value) => state.copyWith(
    //       })),
    //     );
    //   },
    // );
    return Container();
  }
}
