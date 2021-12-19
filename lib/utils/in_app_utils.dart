


import 'package:galss/config/constants.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

Future<List<ProductDetails>> getProducts() async {
  final ProductDetailsResponse response =
  await InAppPurchase.instance.queryProductDetails(kIds);
  if (response.notFoundIDs.isNotEmpty) {
    // Handle the error.
  }
  return response.productDetails;
}