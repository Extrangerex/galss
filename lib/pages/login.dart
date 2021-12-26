import 'package:flutter/material.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ImagedBackgroundContainer(child: loginForm());
  }

  Widget loginForm() {
    return Form(
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
        ],
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
    );
  }

  Widget _usernameField() {
    return TextFormField();
  }

  Widget _loginBtn() {
    return TextButton(onPressed: () {}, child: const Text('Login'));
  }
}
