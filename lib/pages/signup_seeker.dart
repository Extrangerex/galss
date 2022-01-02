import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_state.dart';
import 'package:galss/blocs/signup/signup_bloc.dart';
import 'package:galss/blocs/signup/signup_event.dart';
import 'package:galss/blocs/signup/signup_state.dart';
import 'package:galss/models/country.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';
import 'package:intl/intl.dart';

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
        BlocProvider(create: (create) => CountryBloc(CountryState())),
        BlocProvider(
            create: (create) => SignUpBloc(SignUpState(),
                countryBloc: create.read<CountryBloc>()))
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
    return Form(
        key: _formKey,
        child: Column(
          children: [
            _nameField(),
            _dobField(),
            _emailField(),
            _countryField(),
            const Spacer(),
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
        ));
  }

  Widget _btnSubmit() {
    return TextButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) return;

          context.read<SignUpBloc>().add(SignUpFormSubmitted());
        },
        child: const Text('enviar'));
  }

  Widget _termsAndConditionsField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return CheckboxListTile(
          selected: state.licenseTermsAccepted,
          value: state.licenseTermsAccepted,
          title: const Text('Acepto los terminos y condiciones'),
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
        return TextFormField(
          onChanged: (v) {
            context.read<SignUpBloc>().add(SignUpNameChanged(name: v));
          },
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
          child: TextFormField(
            controller: _dobController,
            onChanged: (value) {
              blocContext
                  .read<SignUpBloc>()
                  .add(SignUpDateOfBirthChanged(dob: DateTime.parse(value)));
            },
            decoration: const InputDecoration(
                enabled: false, hintText: 'Fecha de nacimiento'),
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          onChanged: (v) {
            context.read<SignUpBloc>().add(SignUpEmailChanged(email: v));
          },
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          onChanged: (v) {
            context.read<SignUpBloc>().add(SignUpPasswordChanged(password: v));
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
                const Text('País'),
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
