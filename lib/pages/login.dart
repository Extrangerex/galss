

import 'package:flutter/material.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';

class Login extends StatefulWidget {

  const Login({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ImagedBackgroundContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(image: logo, width: 200,),
          SizedBox(height: 10,)

        ],
      ),
    );
  }

}