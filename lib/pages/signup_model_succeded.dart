import 'package:flutter/material.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/shared/imaged_background_container.dart';

class SignUpModelSucceded extends StatelessWidget {
  const SignUpModelSucceded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ImagedBackgroundContainer(
        child: SizedBox.expand(
          child: Container(
            color: Colors.black54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      S.current.your_request_was_received_see_you_in_48hr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1,
                    )),
                const SizedBox(
                  height: 10,
                ),
                _continueBtn()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _continueBtn() {
    return ElevatedButton(
        onPressed: () {
          locator<NavigationService>().pushRemoveUntil('/login');
          return;
        },
        child: Text(S.current.prompt_next));
  }
}
