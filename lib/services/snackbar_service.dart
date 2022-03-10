import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> globalScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class SnackbarService {
  showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 2000),
    );

    globalScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }
}
