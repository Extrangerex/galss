import 'package:flutter/material.dart';
import 'package:galss/main.dart';
import 'package:galss/pages/login.dart';
import 'package:galss/pages/signup.dart';
import 'package:galss/pages/signup_seeker.dart';

class RouterGenerator {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (builder) => const MyHomePage(),
    '/login': (builder) => const Login(),
    '/signup': (builder) => const SignUp(),
    '/signup/seeker': (builder) => const SignupSeeker()
  };
}
