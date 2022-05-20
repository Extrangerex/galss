import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galss/config/constants.dart';
import 'package:purchases_flutter/object_wrappers.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PaymentService {
  Future<void> isSubscribed(Function(dynamic, bool) cb) async {
    try {
      Purchases.addPurchaserInfoUpdateListener((purchase) async {
        PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

        bool isSubscribed = false;

        if (purchaserInfo.entitlements.all[revenueCatEntitlementKey] != null &&
            (purchaserInfo
                    .entitlements.all[revenueCatEntitlementKey]?.isActive ??
                false)) {
          // monthly subscription is active
          isSubscribed = true;
        }

        cb(null, isSubscribed);
      });
    } catch (e) {
      cb(e, false);
    }
  }

  Future<Offering?> fetchOffer(String identifier) async {
    try {
      final offerings = await Purchases.getOfferings().catchError((e) {
        debugPrint("Error: $e");
        return null;
      });

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
