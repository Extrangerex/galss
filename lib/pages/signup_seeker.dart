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
import 'package:galss/shared/column_spacing.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/light_themed_widget.dart';
import 'package:galss/shared/logo.dart';
import 'package:galss/theme/input_bordered_decoration.dart';
import 'package:galss/utils/validators.dart';
import 'package:intl/intl.dart';

import '../services/snackbar_service.dart';

class SignupSeeker extends StatefulWidget {
  const SignupSeeker({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupSeekerState();
}

class _SignupSeekerState extends State<SignupSeeker> {
  final _formKey = GlobalKey<FormState>();
  final _dobController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showSnack(String title) {
    final snackBar = SnackBar(
        content: Text(
      title,
      style: const TextStyle(
        fontSize: 15,
      ),
    ));
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

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
      child: ScaffoldMessenger(
        key: scaffoldMessengerKey,
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
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.formState is FormSuccessStatus) {
          locator<SnackbarService>()
              .showMessage(S.current.user_seeker_registered);

          locator<NavigationService>().pushRemoveUntil('/',
              arguments: (state.formState as FormSuccessStatus).payload);
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
      child: Form(
          key: _formKey,
          child: ColumnSpacing(
            spacing: 12,
            items: [
              ListTile(title: _nameField()),
              ListTile(title: _dobField()),
              ListTile(title: _emailField()),
              ListTile(title: _countryField()),
              ListTile(title: _passwordField()),
              ListTile(title: _retypePasswordField()),
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
          enableFeedback: true,
          value: state.licenseTermsAccepted,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(S.current.terms_conditions_accept_disclaimer),
          onChanged: (v) {
            if (v == null) return;

            context.read<SignUpBloc>().add(
                SignUpLicenseTermsAcceptedChanged(licenseTermsAccepted: v));
          },
        );
      },
    );
  }

  Widget _inputField({required Widget child, ThemeData? data}) {
    return LightThemedWidget(
      child: child,
    );
  }

  Widget _nameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _inputField(
          child: TextFormField(
            validator: (value) =>
                (value ?? "").isEmpty ? S.current.error_field_required : null,
            decoration:
                InputWhiteFilledBorderedDecoration(hintText: S.current.name),
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
        return _inputField(
          child: TextFormField(
            controller: _dobController,
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
            readOnly: true,
            enableInteractiveSelection: false,
            validator: (value) =>
                (value ?? "").isEmpty ? S.current.error_field_required : null,
            decoration: InputWhiteFilledBorderedDecoration(
                hintText: S.current.birthdate),
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return _inputField(
          child: TextFormField(
            decoration: InputWhiteFilledBorderedDecoration(
                hintText: S.current.prompt_email),
            validator: (value) {
              if (!Validators().validateEmail(value!)) {
                return S.current.error_invalid_email;
              }

              return value.isEmpty ? S.current.error_field_required : null;
            },
            onChanged: (v) {
              context.read<SignUpBloc>().add(SignUpEmailChanged(email: v));
            },
          ),
        );
      },
    );
  }

  Widget _retypePasswordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
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
            decoration: InputWhiteFilledBorderedDecoration(
                hintText: S.current.retype_password),
            onChanged: (v) {
              context
                  .read<SignUpBloc>()
                  .add(SignUpPasswordConfirmationChanged(password: v));
            },
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
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
            decoration: InputWhiteFilledBorderedDecoration(
                hintText: S.current.prompt_password),
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
    return BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        return _inputField(
          child: DropdownButtonFormField<Country>(
              decoration: const InputWhiteFilledBorderedDecoration(),
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
