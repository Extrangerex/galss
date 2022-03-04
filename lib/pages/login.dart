import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/login/login_bloc.dart';
import 'package:galss/blocs/login/login_event.dart';
import 'package:galss/blocs/login/login_state.dart';
import 'package:galss/config/constants.dart';
import 'package:galss/form_submission_status.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_login.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/services/shared_preferences.dart';
import 'package:galss/shared/column_spacing.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';
import 'package:galss/theme/button_styles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

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
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => UserBloc()),
            BlocProvider(create: (context) => LoginBloc())
          ],
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state.authLoginData != null) {
                locator<SharedPreferencesService>().setItem(
                    SharedPrefs.authData, jsonEncode(state.authLoginData));
                locator<NavigationService>().pushRemoveUntil('/');
              }
            },
            child: ImagedBackgroundContainer(child: loginForm()),
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.formState is FormSuccessStatus) {
          context.read<UserBloc>().add(UserIsConnected(
              authLoginData: ApiLogin.fromJson(
                  (state.formState as FormSuccessStatus).payload)));
        } else if (state.formState is FormFailedStatus) {
          final statusCode = (state.formState as FormFailedStatus).status;

          if (statusCode == 404 || statusCode == 400) {
            showSnack(S.current.not_valid_username_password);
          } else if (statusCode == 403) {
            showSnack(S.current.error_inactive_account);
          } else {
            showSnack(S.current.something_went_wrong);
          }

          context.read<LoginBloc>().add(const LoginFormStatusChanged(
              formSubmissionStatus: InitialFormStatus()));
        }
      },
      child: Form(
        key: _formKey,
        child: ColumnSpacing(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          items: [
            const Image(
              image: logo,
              width: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(title: _usernameField()),
            ListTile(title: _passwordField()),
            _loginBtn(),
            _signupBtn()
          ],
        ),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return _inputField(
          child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
            hintText: S.current.prompt_password, border: InputBorder.none),
        validator: (value) => null,
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      ));
    });
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

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return _inputField(
          child: TextFormField(
        validator: (value) => null,
        decoration: InputDecoration(
            hintText: S.current.prompt_email, border: InputBorder.none),
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginUsernameChanged(username: value)),
      ));
    });
  }

  Widget _loginBtn() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => state.formState is FormSubmittingStatus
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: holoGreenDarkBtnStyle,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginFormSubmitted());
                  }
                },
                child: Text(S.current.action_sign_in_short)));
  }

  Widget _signupBtn() {
    return ElevatedButton(
        style: grayBtnStyle,
        onPressed: () {
          locator<NavigationService>().navigateTo('/signup');
        },
        child: Text(S.current.sign_up));
  }
}
