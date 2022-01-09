import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_event.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/blocs/signup/signup_bloc.dart';
import 'package:galss/blocs/signup/signup_event.dart';
import 'package:galss/blocs/signup/signup_state.dart';
import 'package:galss/form_submission_status.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/models/country.dart';
import 'package:galss/models/user_type.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';

class SignUpModel extends StatefulWidget {
  const SignUpModel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpModelState();
}

class _SignUpModelState extends State<SignUpModel> {
  final _formKey = GlobalKey<FormState>();
  final _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (create) =>
                  CountryBloc(CountryState())..add(const FetchListCountry())),
          BlocProvider(
              create: (create) =>
                  SignUpBloc(SignUpState(userType: UserType.model)))
        ],
        child: ImagedBackgroundContainer(child: _form()),
      ),
    );
  }

  Widget _form() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.formState is FormSuccessStatus) {
          locator<NavigationService>()
              .pushRemoveUntil('/signup/model/succeded');
          return;
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: logo,
              width: 200,
            ),
            Text(S.current.sign_up_form_for_galss_models),
            Text(S.current.fonts_with_asterisk_are_mandatory),
            Row(
              children: [
                Flexible(child: _nameField()),
                const SizedBox(
                  width: 10,
                ),
                Flexible(child: _dobField()),
              ],
            ),
            _emailField(),
            _countryField(),
            _passwordField(),
            const SizedBox(
              height: 10,
            ),
            Text(S.current.prompt_terms_conditions),
            _termsAndConditionsField(),
            _btnSubmit()
          ],
        ),
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
      obscureText: true,
      decoration: InputDecoration(hintText: S.current.prompt_password),
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

  Widget _btnSubmit() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        if (state.formState is FormSubmittingStatus) {
          return const CircularProgressIndicator();
        }

        return ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              context.read<SignUpBloc>().add(SignUpFormSubmitted());
            },
            child: Text(S.current.sign_up));
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
                    context
                        .read<SignUpBloc>()
                        .add(SignUpCountryChanged(country: v));
                  }),
            ],
          ),
        );
      },
    );
  }
}
