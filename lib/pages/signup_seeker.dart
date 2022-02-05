import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/country/country_bloc.dart';
import 'package:galss/blocs/country/country_event.dart';
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
        BlocProvider(
            create: (create) => CountryBloc()..add(const FetchListCountry())),
        BlocProvider(
            create: (create) => SignUpBloc(
                  SignUpState(userType: UserType.seeker),
                ))
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Image(
            image: logo,
            width: 50,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: ImagedBackgroundContainer(
            child: SafeArea(
          child: ListView(
            children: [_signUpForm()],
          ),
        )),
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.formState is FormSuccessStatus) {
          locator<NavigationService>().pushRemoveUntil(
              '/signup/seeker/subscribe',
              arguments: (state.formState as FormSuccessStatus).payload);
        }
      },
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              ListTile(title: _nameField()),
              ListTile(title: _dobField()),
              ListTile(title: _emailField()),
              _countryField(),
              ListTile(title: _passwordField()),
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
        return TextFormField(
          validator: (value) =>
              (value ?? "").isEmpty ? S.current.error_field_required : null,
          decoration: InputDecoration(hintText: S.current.name),
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

            blocContext
                .read<SignUpBloc>()
                .add(SignUpDateOfBirthChanged(dob: result));

            setState(() {
              _dobController.text = DateFormat("yyyy-MM-dd").format(result);
            });
          },
          child: TextFormField(
            controller: _dobController,
            validator: (value) =>
                (value ?? "").isEmpty ? S.current.error_field_required : null,
            decoration:
                InputDecoration(enabled: false, hintText: S.current.birthdate),
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(hintText: S.current.prompt_email),
          validator: (value) =>
              (value ?? "").isEmpty ? S.current.error_field_required : null,
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
          validator: (v) {
            return (v ?? "").isEmpty ? S.current.error_field_required : null;
          },
          decoration: InputDecoration(hintText: S.current.prompt_password),
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
        return ListTile(
          title: Text(S.current.country),
          subtitle: DropdownButton<Country>(
              items: context
                  .read<CountryBloc>()
                  .state
                  .countries
                  .map((e) => DropdownMenuItem<Country>(
                        child: Text(e.name!),
                        value: e,
                      ))
                  .toList(),
              isExpanded: true,
              value: state.country,
              isDense: true,
              // hint: Text(S.current.country),
              onChanged: (v) {
                if (v == null) return;
                context
                    .read<SignUpBloc>()
                    .add(SignUpCountryChanged(country: v));
              }),
        );
      },
    );
  }
}
