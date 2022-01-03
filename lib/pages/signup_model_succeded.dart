import 'package:flutter/material.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';

class SignUpModelSucceded extends StatelessWidget {
  const SignUpModelSucceded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            Text(S.current.your_request_was_received_see_you_in_48hr)
          ],
        ),
      ),
    );
  }
}
