import 'package:flutter/services.dart';
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

  Future<bool> purchase(Package package) async {
    try {
      PurchaserInfo purchaserInfo = await Purchases.purchasePackage(package);
      if (purchaserInfo.entitlements.all[package.identifier]!.isActive) {
        // Unlock that great "pro" content
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        throw Exception(e);
      }
    }

    return false;
  }
}
