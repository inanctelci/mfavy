import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../controllers/subscription/subscription_controller.dart';
import '../../../export.dart';

class PremiumPlan extends StatefulWidget {
  const PremiumPlan({Key? key}) : super(key: key);

  @override
  State<PremiumPlan> createState() => _PremiumPlanState();
}

class _PremiumPlanState extends State<PremiumPlan> {
  late final String userID;
  var myProducts = [];

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  _initPlatformState() async {
    Offerings offerings;
    try {
      offerings = await Purchases.getOfferings();
      myProducts = offerings.current!.availablePackages;
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    SubsController subsController = Get.find<SubsController>();

    return Container(
      height: Get.height * 0.3,
      width: Get.width,
      color: AppConstants.kAppBlack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Premium Planınız',
            style: TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: Get.width * 0.9,
              height: Get.height * 0.2,
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.width * 0.01),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: AppConstants.kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    subsController.currentPlan.value == 1
                        ? 'MFavy Music Aylık Abonelik (MFavy Music App)'
                        : subsController.currentPlan.value == 2
                            ? 'MFavy Music Yıllık Abonelik (MFavy Music App)'
                            : '',
                    style: TextStyle(
                      fontFamily: 'Mulish-ExtraBold',
                      fontSize: Get.width * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subsController.currentPlan.value == 1
                        ? '₺4,99'
                        : subsController.currentPlan.value == 2
                            ? '₺49,99'
                            : '',
                    style: TextStyle(
                      fontFamily: 'Mulish-ExtraBold',
                      fontSize: Get.width * 0.1,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Yenilenme Tarihi ${subsController.expDate}',
                    style: TextStyle(
                      fontFamily: 'Mulish-ExtraBold',
                      fontSize: Get.width * 0.04,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
