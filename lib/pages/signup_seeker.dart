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
import 'package:galss/models/country.dart';
import 'package:galss/models/user_type.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/input_container.dart';
import 'package:galss/shared/logo.dart';

class SignupSeeker extends StatefulWidget {
  const SignupSeeker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupSeekerState();
}

class _SignupSeekerState extends State<SignupSeeker> {
  final _formKey = GlobalKey<FormState>();
  final _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (create) =>
                CountryBloc(CountryState())..add(const FetchListCountry())),
        BlocProvider(
            create: (create) => SignUpBloc(
                  SignUpState(userType: UserType.seeker),
                ))
      ],
      child: Scaffold(
        body: ImagedBackgroundContainer(
            child: ListView(
          children: [
            Column(
              children: const [
                Image(image: logo, width: 100),
              ],
            ),
            _signUpForm()
          ],
        )),
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        print(state.formState);
        if (state.formState is FormSuccessStatus) {}
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              _nameField(),
              _dobField(),
              _emailField(),
              _countryField(),
              _passwordField(),
              const SizedBox(
                height: 20,
              ),
              _termsAndConditionsField(),
              const SizedBox(
                height: 20,
              ),
              _btnSubmit()
            ],
          )),
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

  Widget _nameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return InputContainer(
          child: TextFormField(
            decoration: InputDecoration(hintText: S.current.name),
            onChanged: (v) {
              context.read<SignUpBloc>().add(SignUpNameChanged(name: v));
            },
          ),
        );
      },
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
          child: InputContainer(
            child: TextFormField(
              controller: _dobController,
              onChanged: (value) {
                blocContext
                    .read<SignUpBloc>()
                    .add(SignUpDateOfBirthChanged(dob: DateTime.parse(value)));
              },
              decoration: InputDecoration(
                  enabled: false, hintText: S.current.birthdate),
            ),
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return InputContainer(
          child: TextFormField(
            decoration: InputDecoration(hintText: S.current.prompt_email),
            onChanged: (v) {
              context.read<SignUpBloc>().add(SignUpEmailChanged(email: v));
            },
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return InputContainer(
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(hintText: S.current.prompt_password),
            onChanged: (v) {
              context
                  .read<SignUpBloc>()
                  .add(SignUpPasswordChanged(password: v));
            },
          ),
        );
      },
    );
  }

  Widget _countryField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Theme(
          data: ThemeData.light(),
          child: InputContainer(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.country,
                    style: const TextStyle(color: Colors.black),
                  ),
                  DropdownButton<Country>(
                      items: context
                          .read<CountryBloc>()
                          .state
                          .countries
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
          ),
        );
      },
    );
  }
}
