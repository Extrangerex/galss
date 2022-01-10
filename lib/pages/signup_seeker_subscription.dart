import 'package:flutter/material.dart';
import 'package:galss/config/constants.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/services/payment_service.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';
import 'package:galss/theme/button_styles.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SignupSeekerSubscription extends StatefulWidget {
  final int userId;
  const SignupSeekerSubscription({Key? key, required this.userId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupSeekerSubscriptionState();
}

class _SignupSeekerSubscriptionState extends State<SignupSeekerSubscription> {
  Offering? offerins;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _monthlySubscriptionBtn() {
    return FutureBuilder<Offering?>(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          return ElevatedButton(
              onPressed: () {
                // purchase

                locator<PaymentService>().purchase(snapshot.data!.monthly!);
              },
              style: btnLgStyle,
              child: Text(
                  "${S.current.monthly} ${snapshot.data?.monthly?.product.priceString ?? ""}"));
        },
        future:
            locator<PaymentService>().fetchOffer("galss_monthly_subscription"));
  }

  Widget _annualSubscriptionBtn() {
    return FutureBuilder<Offering?>(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data?.annual == null) {
            return const CircularProgressIndicator();
          }
          return ElevatedButton(
              onPressed: () {
                // purchase
                locator<PaymentService>().purchase(snapshot.data!.annual!);
              },
              style: btnLgStyle,
              child: Text(
                  "${S.current.yearly} ${snapshot.data?.annual?.product.priceString ?? ""}"));
        },
        future:
            locator<PaymentService>().fetchOffer("galss_yearly_subscription"));
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
              height: 20,
            ),
            _monthlySubscriptionBtn(),
            const SizedBox(
              height: 10,
            ),
            _annualSubscriptionBtn()
          ],
        ),
      ),
    );
  }
}
