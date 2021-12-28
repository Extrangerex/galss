import 'package:flutter/material.dart';
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
    return ElevatedButton(onPressed: () {}, child: const Text('Buscador'));
  }

  Widget _btnModel() {
    return ElevatedButton(onPressed: () {}, child: const Text('Modelo'));
  }
}
