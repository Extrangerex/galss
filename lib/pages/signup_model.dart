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
import 'package:galss/services/snackbar_service.dart';
import 'package:galss/shared/column_spacing.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';
import 'package:intl/intl.dart';

import '../utils/validators.dart';

class SignUpModel extends StatefulWidget {
  const SignUpModel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpModelState();
}

class _SignUpModelState extends State<SignUpModel> {
  final _formKey = GlobalKey<FormState>();
  final _dobController = TextEditingController();

  void showSnack(String title) {
    locator<SnackbarService>().showMessage(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: logo,
          width: 75,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (create) => CountryBloc()..add(const FetchListCountry())),
          BlocProvider(
              create: (create) =>
                  SignUpBloc(SignUpState(userType: UserType.model)))
        ],
        child: ImagedBackgroundContainer(
            child: SizedBox(
          child: _form(),
        )),
      ),
    );
  }

  Widget _inputField({required Widget child, ThemeData? data}) {
    return Theme(
      data: data ?? ThemeData.light(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black12)),
        child: child,
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
        } else if (state.formState is FormFailedStatus) {
          final data = state.formState as FormFailedStatus;

          if (data.status == 409) {
            showSnack('${S.current.oops}, ${S.current.email_in_use}');
          } else if (data.status == 400) {
            showSnack(
                '${S.current.oops}, ${S.current.technically_there_is_nothing_wrong_but}');
          } else {
            showSnack('${S.current.oops}, ${S.current.something_went_wrong}');
          }
        }
      },
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: ColumnSpacing(
            items: [
              const SizedBox(
                height: 16,
              ),
              ListTile(
                title: Row(
                  children: [
                    Flexible(child: _nameField()),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(child: _dobField()),
                  ],
                ),
              ),
              ListTile(title: _emailField()),
              ListTile(title: _countryField()),
              ListTile(title: _passwordField()),
              ListTile(title: _retypePasswordField()),
              ListTile(title: _termsAndConditionsField()),
              _btnSubmit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return _inputField(
        child: TextFormField(
          validator: (value) =>
              (value ?? "").isEmpty ? S.current.error_field_required : null,
          decoration: InputDecoration(
              hintText: S.current.name, border: InputBorder.none),
          onChanged: (v) =>
              context.read<SignUpBloc>().add(SignUpNameChanged(name: v)),
        ),
      );
    });
  }

  Widget _retypePasswordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return _inputField(
        child: TextFormField(
          obscureText: true,
          validator: (v) {
            var valid =
                (v ?? "").isEmpty ? S.current.error_field_required : null;

            if (state.password != state.passwordConfirmation) {
              return S.current.passwords_must_match;
            }

            return valid;
          },
          decoration: InputDecoration(
              hintText: S.current.retype_password, border: InputBorder.none),
          onChanged: (v) => context
              .read<SignUpBloc>()
              .add(SignUpPasswordConfirmationChanged(password: v)),
        ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return _inputField(
        child: TextFormField(
          obscureText: true,
          validator: (v) {
            var valid =
                (v ?? "").isEmpty ? S.current.error_field_required : null;


            if (state.password != state.passwordConfirmation) {
              return S.current.passwords_must_match;
            }

            return valid;
          },
          decoration: InputDecoration(
              hintText: S.current.prompt_password, border: InputBorder.none),
          onChanged: (v) => context
              .read<SignUpBloc>()
              .add(SignUpPasswordChanged(password: v)),
        ),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return _inputField(
        child: TextFormField(
          validator: (value) {
            if (!Validators().validateEmail(value!)) {
              return S.current.error_invalid_email;
            }

            return value.isEmpty ? S.current.error_field_required : null;
          },
          decoration: InputDecoration(
              hintText: S.current.prompt_email, border: InputBorder.none),
          onChanged: (v) =>
              context.read<SignUpBloc>().add(SignUpEmailChanged(email: v)),
        ),
      );
    });
  }

  Widget _dobField() {
    final legalDatetime =
        DateTime.now().subtract(const Duration(days: 365 * 18));
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (blocContext, state) {
        return _inputField(
          child: TextFormField(
            onTap: () async {
              var result = await showDatePicker(
                context: blocContext,
                initialDate: legalDatetime,
                firstDate:
                    legalDatetime.subtract(const Duration(days: 365 * 80)),
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
            validator: (value) =>
                (value ?? "").isEmpty ? S.current.error_field_required : null,
            controller: _dobController,
            readOnly: true,
            decoration: InputDecoration(
                hintText: S.current.birthdate, border: InputBorder.none),
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

              if (!state.licenseTermsAccepted) {
                showSnack(S.current.prompt_must_accept_terms_conditions);
                return;
              }

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
          title: Text(S.current.terms_conditions_accept_disclaimer),
          controlAffinity: ListTileControlAffinity.leading,
          value: state.licenseTermsAccepted,
          activeColor: Theme.of(context).primaryColor,
          shape: const CircleBorder(),
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
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        return _inputField(
          child: DropdownButtonFormField<Country>(
              validator: (v) =>
                  v == null ? S.current.error_field_required : null,
              hint: Text(S.current.country),
              items: state.countries
                  .map((e) => DropdownMenuItem<Country>(
                        child: Text(e.name!),
                        value: e,
                      ))
                  .toList(),
              isExpanded: true,
              value: context.read<SignUpBloc>().state.country,
              isDense: true,
              decoration: const InputDecoration(border: InputBorder.none),
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
