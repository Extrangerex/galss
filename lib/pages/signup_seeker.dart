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

class SignupSeeker extends StatefulWidget {
  const SignupSeeker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupSeekerState();
}

class _SignupSeekerState extends State<SignupSeeker> {
  final _formKey = GlobalKey<FormState>();

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
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Image(image: logo, width: 100), _signUpForm()],
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
            _emailField(),
            _countryField(),
            _passwordField()
          ],
        ));
  }

  Widget _nameField() {
    return TextFormField(
      onChanged: (v) {
        context.read<SignUpBloc>().add(SignUpNameChanged(name: v));
      },
    );
  }

  Widget _emailField() {
    return TextFormField(
      onChanged: (v) {
        context.read<SignUpBloc>().add(SignUpEmailChanged(email: v));
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
        return DropdownButton<Country>(
            items: state.countries
                .map((e) => DropdownMenuItem<Country>(child: Text(e.name!)))
                .toList(),
            onChanged: (v) {
              context.read<SignUpBloc>().add(SignUpCountryChanged(country: v!));
            });
      },
    );
  }
}
