import 'package:flutter/material.dart';
import 'package:galss/main.dart';
import 'package:galss/services/navigation_service.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  static show() {
    showDialog(
      context: locator<NavigationService>()
          .navigatorKey
          .currentState!
          .overlay!
          .context,
      barrierDismissible: false,
      builder: (context) => LoadingDialog(),
    );
    return;
  }

  static dismiss() {
    locator<NavigationService>().pop();
    return;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
