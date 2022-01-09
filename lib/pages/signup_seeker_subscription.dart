import 'package:flutter/material.dart';
import 'package:galss/main.dart';
import 'package:galss/services/payment_service.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SignupSeekerSubscription extends StatefulWidget {
  final int userId;
  const SignupSeekerSubscription({Key? key, required this.userId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupSeekerSubscriptionState();
}

class _SignupSeekerSubscriptionState extends State<SignupSeekerSubscription> {
  List<Offering> offerins = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    locator<PaymentService>().fetchOffers().then((value) {
      setState(() {
        print(offerins.length);

        offerins = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            ...offerins.map((e) => ElevatedButton(
                onPressed: () {}, child: Text(e.monthly?.product.title ?? ""))),
            ...offerins.map((e) => ElevatedButton(
                onPressed: () {}, child: Text(e.annual?.product.title ?? "")))
          ],
        ),
      ),
    );
  }
}
