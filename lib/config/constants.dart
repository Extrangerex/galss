import 'dart:io';

const Set<String> kIds = <String>{
  "galss_yearly_subscription",
  "galss_monthly_subscription"
};

String get revenueCatKey {
  if (Platform.isAndroid) {
    return 'goog_OzclXrIoLpROpKJugNkUIFniBRz';
  } else if (Platform.isIOS) {
    return 'appl_OylMRLjcxAiHRQJlaQPfcyeqJMXs';
  } else {
    return "";
  }
}

class SharedPrefs {
  static const authData = 'AUTHDATA';
}

String revenueCatEntitlementKey = 'access_all_features';

String get revenueCatSubscriptionMonthlyId {
  if (Platform.isAndroid) {
    return 'galss_monthly_subscription';
  } else if (Platform.isIOS) {
    return 'com.iscodeablesolutions.apps.galss.subscriptions.monthly';
  } else {
    return "";
  }
}

String get revenueCatSubscriptionAnnualId {
  if (Platform.isAndroid) {
    return 'galss_yearly_subscription';
  } else if (Platform.isIOS) {
    return 'com.iscodeablesolutions.apps.galss.subscriptions.year';
  } else {
    return "";
  }
}
