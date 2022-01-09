import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaymentService {
  Future<Offering?> fetchOffer(String identifier) async {
    try {
      final offerings = await Purchases.getOfferings();

      return offerings.getOffering(identifier);
    } catch (e) {
      return null;
    }
  }
}
