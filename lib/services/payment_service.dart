import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galss/config/constants.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:rxdart/subjects.dart';

class PaymentService {
  final BehaviorSubject<bool> isSubscribed = BehaviorSubject()..add(false);

  PaymentService() {
    try {
      Purchases.getPurchaserInfo().then((value) {
        bool _isSubscribed = false;

        if (value.entitlements.all[revenueCatEntitlementKey] != null &&
            (value.entitlements.all[revenueCatEntitlementKey]?.isActive ??
                false)) {
          // monthly subscription is active
          _isSubscribed = true;
        }

        isSubscribed.add(_isSubscribed);
      }).catchError((error) {
        debugPrint("Error: $error");
      });

      Purchases.addPurchaserInfoUpdateListener((purchase) async {
        PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();

        bool _isSubscribed = false;

        if (purchaserInfo.entitlements.all[revenueCatEntitlementKey] != null &&
            (purchaserInfo
                    .entitlements.all[revenueCatEntitlementKey]?.isActive ??
                false)) {
          // monthly subscription is active
          _isSubscribed = true;
        }

        isSubscribed.add(_isSubscribed);
      });
    } catch (e) {
      debugPrint("err: ${e.toString()}");
    }
  }

  Future<Offering?> fetchOffer(String identifier) async {
    try {
      final offerings = await Purchases.getOfferings().catchError((e) {
        debugPrint("Error: $e");
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
