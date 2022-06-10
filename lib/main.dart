import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:galss/config/constants.dart';
import 'package:galss/firebase_options.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/models/api_login.dart';
import 'package:galss/models/user_type.dart';
import 'package:galss/pages/signup_seeker_subscription.dart';
import 'package:galss/router_generator.dart';
import 'package:galss/services/auth_service.dart';
import 'package:galss/services/country_service.dart';
import 'package:galss/services/http_service.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/services/payment_service.dart';
import 'package:galss/services/shared_preferences.dart';
import 'package:galss/services/snackbar_service.dart';
import 'package:galss/services/validation_service.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';
import 'package:galss/theme/variables.dart';
import 'package:galss/services/firebase_messaging_service.dart';
import 'package:get_it/get_it.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final locator = GetIt.I;

final String defaultLocale =
    Platform.localeName; // Returns locale string in the form 'en_US'

void setupLocator() {
  locator.registerSingleton<PaymentService>(PaymentService());
  locator.registerSingleton<HttpService>(HttpService());
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<CountryService>(CountryService());
  locator.registerSingleton<SnackbarService>(SnackbarService());
  locator.registerSingleton<NavigationService>(NavigationService());
  locator
      .registerSingleton<SharedPreferencesService>(SharedPreferencesService());
  locator
      .registerSingleton<FirebaseMessagingService>(FirebaseMessagingService());

  locator.registerSingleton<ValidationService>(ValidationService());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.setDebugLogsEnabled(true);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (Platform.isAndroid) {
    await Purchases.setup("goog_OzclXrIoLpROpKJugNkUIFniBRz");
  } else if (Platform.isIOS) {
    await Purchases.setup("appl_OylMRLjcxAiHRQJlaQPfcyeqJMX");
  }

  setupLocator();

  await locator<FirebaseMessagingService>().load();
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
      scaffoldMessengerKey: globalScaffoldMessengerKey,
      supportedLocales: const [
        Locale('es'),
        Locale('en'),
        Locale('pt'),
        Locale('fr'),
        Locale('it'),
        Locale('hi')
      ],
      locale: Locale(defaultLocale.split('_')[0]),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: primaryColor,
          primaryColorDark: primaryColorDark),
      routes: RouterGenerator.routes,
      initialRoute: '/',
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

    locator<AuthService>().authData.then((value) {
      if (value.userType != null) {
        if (value.userType == UserType.seeker.index) {
          // check if email is verified

          locator<PaymentService>().isSubscribed.listen((p1) {
            if (p1) {
              locator<NavigationService>().navigateTo('/seeker');
            } else {
              locator<NavigationService>()
                  .navigateTo('/signup/seeker/subscribe');
            }
          });
        } else if (value.userType == UserType.model.index) {
          locator<NavigationService>().navigateTo('/model');
        }

        return;
      }

      locator<NavigationService>().navigateTo('/login');
    });

    super.initState();
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
