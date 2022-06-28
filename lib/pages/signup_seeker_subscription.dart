import 'package:flutter/material.dart';
import 'package:galss/config/constants.dart';
import 'package:galss/generated/l10n.dart';
import 'package:galss/main.dart';
import 'package:galss/services/navigation_service.dart';
import 'package:galss/services/payment_service.dart';
import 'package:galss/shared/column_spacing.dart';
import 'package:galss/shared/imaged_background_container.dart';
import 'package:galss/shared/logo.dart';
import 'package:galss/theme/button_styles.dart';
import 'package:galss/utils/intent-utils.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SignupSeekerSubscription extends StatefulWidget {
  const SignupSeekerSubscription({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignupSeekerSubscriptionState();
}

class _SignupSeekerSubscriptionState extends State<SignupSeekerSubscription> {
  Offering? offerins;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    locator<PaymentService>().isSubscribed.listen(
      (p1) {
        if (p1) {
          locator<NavigationService>().navigateTo('/seeker');
        }

        setState(() {});
      },
    );
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

  Widget _termsConditionsBtn() {
    return GestureDetector(
        onTap: () {
          launchUrlInBrowser(
              Uri.parse("http://www.thegalssapp.com/privacy-policy/"));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text:
                        "${S.current.subscription_terms_conditions_accept_disclaimer} ",
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
                TextSpan(
                    text: S.current.prompt_terms_conditions,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold)),
              ])),
        ));
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
      bottomSheet: _termsConditionsBtn(),
      body: ImagedBackgroundContainer(
        child: ColumnSpacing(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          items: [
            const Image(
              image: logo,
              width: 200,
            ),
            _monthlySubscriptionBtn(),
            _annualSubscriptionBtn()
          ],
        ),
      ),
    );
  }
}
