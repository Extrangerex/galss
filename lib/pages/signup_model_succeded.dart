import 'package:flutter/material.dart';
import 'package:galss/shared/logo.dart';

class SignUpModelSucceded extends StatelessWidget {
  const SignUpModelSucceded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: logo,
            width: 200,
          ),
          SizedBox(
            height: 10,
          ),
          Text('data')
        ],
      ),
    );
  }
}
