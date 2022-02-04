import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/api_fetch_status.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_event.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/models/city.dart';
import 'package:galss/models/country.dart';
import 'package:galss/models/user.dart';
import 'package:galss/services/navigation_service.dart';

class EditCurrentLocationModal extends StatefulWidget {
  final Country country;

  const EditCurrentLocationModal({Key? key, required this.country})
      : super(key: key);

  @override
  State<EditCurrentLocationModal> createState() =>
      _EditCurrentLocationModalState();
}

class _EditCurrentLocationModalState extends State<EditCurrentLocationModal> {
  City? city;

  handleChangeCurrentLocation(BuildContext context, User? user, City? city) {
    if (user == null && city == null) {
      return;
    }

    context
        .read<UserBloc>()
        .add(UserCurrentLocationChanged(city: city!, user: user!));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => UserBloc()..add(const FetchUserData())),
        BlocProvider(
            create: (create) => CountryBloc()
              ..add(FetchListCities(countryId: widget.country.id!)))
      ],
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // TODO: implement listener

          if (state.actionFetchStatus is ApiFetchSuccededStatus) {
            locator<NavigationService>().pop();
          }
        },
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            // constraints: const BoxConstraints(minHeight: 120),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    S.current.change_current_location,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                citiesDropdown(),
                Row(
                  children: [
                    const Spacer(),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return TextButton(
                            onPressed: () {
                              handleChangeCurrentLocation(
                                  context, state.user, city);
                            },
                            child: Text(S.current.save));
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          locator<NavigationService>().pop();
                        },
                        child: Text(S.current.cancel)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget citiesDropdown() {
    return BlocBuilder<CountryBloc, CountryState>(builder: (context, state) {
      return DropdownButton<City>(
        isExpanded: true,
        items: state.cities
            .map((e) => DropdownMenuItem<City>(
                  child: Text(e.name!),
                  value: e,
                ))
            .toList(),
        onChanged: (city) {
          setState(() {
            this.city = city;
          });
        },
        value: city,
        hint: Text(S.current.pick_a_city),
      );
    });
  }
}
