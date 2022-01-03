import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/blocs/signup/signup_bloc.dart';
import 'package:galss/blocs/signup/signup_event.dart';
import 'package:galss/blocs/signup/signup_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/models/country.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';

class SignUpModel extends StatefulWidget {
  const SignUpModel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpModelState();
}

class _SignUpModelState extends State<SignUpModel> {
  final _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (create) => CountryBloc(CountryState())),
          BlocProvider(
              create: (create) => SignUpBloc(SignUpState(),
                  countryBloc: create.read<CountryBloc>()))
        ],
        child: ImagedBackgroundContainer(
            child: Column(
          children: [
            const Image(
              image: logo,
              width: 200,
            ),
            Text(S.current.sign_up_form_for_galss_models),
            Text(S.current.fonts_with_asterisk_are_mandatory)
          ],
        )),
      ),
    );
  }

  Widget _nameField() {
    return TextFormField(
      decoration: InputDecoration(hintText: S.current.name),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      decoration: InputDecoration(hintText: S.current.name),
    );
  }

  Widget _emailField() {
    return TextFormField(
      decoration: InputDecoration(hintText: S.current.prompt_email),
    );
  }

  Widget _dobField() {
    final legalDatetime =
        DateTime.now().subtract(const Duration(days: 365 * 18));
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (blocContext, state) {
        return GestureDetector(
          onTap: () async {
            var result = await showDatePicker(
              context: blocContext,
              initialDate: legalDatetime,
              firstDate: legalDatetime.subtract(const Duration(days: 365 * 80)),
              lastDate: legalDatetime,
            );

            if (result == null) return;

            setState(() {
              _dobController.text = result.toString();
            });
          },
          child: TextFormField(
            controller: _dobController,
            onChanged: (value) {
              blocContext
                  .read<SignUpBloc>()
                  .add(SignUpDateOfBirthChanged(dob: DateTime.parse(value)));
            },
            decoration:
                InputDecoration(enabled: false, hintText: S.current.birthdate),
          ),
        );
      },
    );
  }

  Widget _termsAndConditionsField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return CheckboxListTile(
          selected: state.licenseTermsAccepted,
          value: state.licenseTermsAccepted,
          title: Text(S.current.prompt_accept_terms_conditions),
          onChanged: (v) {
            if (v == null) return;

            context.read<SignUpBloc>().add(
                SignUpLicenseTermsAcceptedChanged(licenseTermsAccepted: v));
          },
        );
      },
    );
  }

  Widget _countryField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(color: Colors.white),
          child: Theme(
            data: ThemeData(brightness: Brightness.light),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.current.country),
                DropdownButton<Country>(
                    items: state.countries
                        .map((e) =>
                            DropdownMenuItem<Country>(child: Text(e.name!)))
                        .toList(),
                    isExpanded: true,
                    onChanged: (v) {
                      if (v == null) return;
                      context
                          .read<SignUpBloc>()
                          .add(SignUpCountryChanged(country: v));
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
