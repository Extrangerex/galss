import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/pages/login.dart';
import 'package:galss/pages/signup_seeker.dart';
import 'package:galss/router_generator.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/country_service.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/payment_service.dart';
import 'package:get_it/get_it.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final locator = GetIt.I;

void setupLocator() {
  locator.registerSingleton<PaymentService>(PaymentService());
  locator.registerSingleton<HttpService>(HttpService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<CountryService>(CountryService());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.setDebugLogsEnabled(true);

  if (Platform.isAndroid) {
    await Purchases.setup("goog_OzclXrIoLpROpKJugNkUIFniBRz");
  } else if (Platform.isIOS) {
    await Purchases.setup("appl_OylMRLjcxAiHRQJlaQPfcyeqJMX");
  }

  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate
      ],
      supportedLocales: const [Locale('es')],
      locale: const Locale('es'),
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: RouterGenerator.routes,
      initialRoute: '/signup/model',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Login(),
    );
  }
}
