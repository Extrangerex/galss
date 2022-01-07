import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_events.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/blocs/login/login_bloc.dart';
import 'package:galss/blocs/login/login_event.dart';
import 'package:galss/blocs/login/login_state.dart';
import 'package:galss/form_submission_status.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/models/api_login.dart';
import 'package:galss/models/user_type.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldMessagerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldMessenger(
        key: _scaffoldMessagerKey,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => UserBloc()),
            BlocProvider(create: (context) => LoginBloc())
          ],
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state.isAuthenticated) {
                if (state.authLoginData?.userType == UserType.model.index) {
                  print('object');
                  locator<NavigationService>().pushRemoveUntil('/model');
                  return;
                }
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
                  (state.formState as FormSuccessStatus).payload!)));
        } else if (state.formState is FormFailedStatus) {
          _scaffoldMessagerKey.currentState?.showSnackBar(SnackBar(
              content: Text(
                  (state.formState as FormFailedStatus).exception.toString())));
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: logo,
              width: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            _usernameField(),
            _passwordField(),
            _loginBtn(),
            const SizedBox(
              height: 10,
            ),
            _signupBtn()
          ],
        ),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        validator: (value) => null,
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      );
    });
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
        validator: (value) => null,
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginUsernameChanged(username: value)),
      );
    });
  }

  Widget _loginBtn() {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => state.formState is FormSubmittingStatus
            ? const CircularProgressIndicator()
            : TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginFormSubmitted());
                  }
                },
                child: Text(S.current.action_sign_in_short)));
  }

  Widget _signupBtn() {
    return TextButton(
        onPressed: () {
          locator<NavigationService>().navigateTo('/signup');
        },
        child: Text(S.current.sign_up));
  }
}
