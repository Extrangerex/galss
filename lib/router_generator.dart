import 'package:flutter/material.dart';
import 'package:galss/main.dart';
import 'package:galss/pages/login.dart';
import 'package:galss/pages/model/home_model.dart';
import 'package:galss/pages/seeker/home_seeker.dart';
import 'package:galss/pages/signup.dart';
import 'package:galss/pages/signup_model.dart';
import 'package:galss/pages/signup_model_succeded.dart';
import 'package:galss/pages/signup_seeker.dart';
import 'package:galss/pages/signup_seeker_subscription.dart';

class RouterGenerator {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (builder) => const Home(),
    '/login': (builder) => const Login(),
    '/signup': (builder) => const SignUp(),
    '/signup/seeker': (builder) => const SignupSeeker(),
    '/signup/seeker/subscribe': (builder) => const SignupSeekerSubscription(),
    '/signup/model': (builder) => const SignUpModel(),
    '/signup/model/succeded': (builder) => const SignUpModelSucceded(),
    '/model': (builder) => const HomeModel(),
    '/seeker': (builder) => const HomeSeeker()
  };
}
