import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:galss/blocs/auth/user_bloc.dart';
import 'package:galss/blocs/auth/user_state.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/models/api_login.dart';
import 'package:galss/models/user_type.dart';
import 'package:galss/router_generator.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/country_service.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/services/payment_service.dart';
import 'package:galss/services/shared_preferences.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';
import 'package:galss/theme/variables.dart';
import 'package:get_it/get_it.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final locator = GetIt.I;

void setupLocator() {
  locator.registerSingleton<PaymentService>(PaymentService());
  locator.registerSingleton<HttpService>(HttpService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<CountryService>(CountryService());
  locator.registerSingleton<NavigationService>(NavigationService());
  locator
      .registerSingleton<SharedPreferencesService>(SharedPreferencesService());
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
      navigatorKey: locator<NavigationService>().navigatorKey,
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
          primaryColor: primaryColor,
          primaryColorDark: primaryColorDark),
      routes: RouterGenerator.routes,
      initialRoute: '/login',
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    locator<AuthService>().authData.then((value) {
      if (value.userType != null) {
        locator<NavigationService>().pushRemoveUntil(
            value.userType == UserType.model.index ? '/model' : '/seeker');
        return;
      }

      locator<NavigationService>().navigateTo('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiLogin>(
      future: locator<AuthService>().authData,
      builder: (context, snapshot) {
        return Scaffold(
          body: ImagedBackgroundContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(
                  image: logo,
                  width: 200,
                ),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator()
              ],
            ),
          ),
        );
      },
    );
  }
}
