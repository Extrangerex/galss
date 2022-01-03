import 'package:flutter/material.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImagedBackgroundContainer(
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
          _btnSeeker(),
          const SizedBox(
            height: 10,
          ),
          _btnModel()
        ],
      )),
    );
  }

  Widget _btnSeeker() {
    return ElevatedButton(
        onPressed: () {
          locator<NavigationService>().navigateTo('/signup/seeker');
        },
        child: Text(S.current.seeker));
  }

  Widget _btnModel() {
    return ElevatedButton(
        onPressed: () {
          locator<NavigationService>().navigateTo('/signup/model');
        },
        child: Text(S.current.model));
  }
}
