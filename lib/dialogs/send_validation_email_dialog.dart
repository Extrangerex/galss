import 'package:flutter/material.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/services/snackbar_service.dart';
import 'package:galss/services/validation_service.dart';
import 'package:galss/services/navigation_service.dart';

class SendValidationEmailDialog extends StatelessWidget {
  final String? email;

  static Show(String email) {
    showDialog(
        context: locator<NavigationService>().navigatorKey.currentContext!,
        builder: (context) => SendValidationEmailDialog(email: email));
  }

  const SendValidationEmailDialog({Key? key, @required this.email})
      : super(key: key);

  handleSubmit() {
    locator<ValidationService>().sendValidationCode(email).then((value) {
      locator<NavigationService>().navigateTo('/');
    }).catchError((error) {
      locator<SnackbarService>().showMessage(S.current.something_went_wrong);
    });
  }

  Widget sendValidationEmailButton(BuildContext context) {
    return TextButton(
      child: Text(S.current.prompt_next,
          style: TextStyle(color: Theme.of(context).primaryColor)),
      onPressed: handleSubmit,
    );
  }

  Widget cancelButton() {
    return TextButton(
      child: Text(S.current.cancel),
      onPressed: () {
        locator<NavigationService>().navigateTo('/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.oops),
      content: Text(S.current.please_confirm_your_email_address),
      actions: [sendValidationEmailButton(context), cancelButton()],
    );
  }
}
