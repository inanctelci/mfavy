import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../export.dart';

class SubsController extends GetxController {
  init() async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();
    if (customerInfo.entitlements.active.isEmpty) {
      currentPlan.value = 0;
    } else if (customerInfo.activeSubscriptions[0] == 'aylik_abonelik') {
      currentPlan.value = 1;
      expDate = customerInfo.latestExpirationDate!;
    } else if (customerInfo.activeSubscriptions[0] == 'yillik_abonelik') {
      currentPlan.value = 2;
      expDate = customerInfo.latestExpirationDate!;
    }
  }

  var myProducts;

  initPlatformState() async {
    Offerings offerings;
    try {
      offerings = await Purchases.getOfferings();
      myProducts = offerings.current!.availablePackages;
    } on PlatformException {}
  }

  @override
  void onInit() {
    init();
    initPlatformState();
    super.onInit();
  }

  RxInt currentPlan = 0.obs;
  var expDate = '';
}
