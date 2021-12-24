import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaymentService {
  Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      // return [current.] ?? [];
      return [];
    } catch (e) {
      return [];
    }
  }
}
