import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../../controllers/subscription/subscription_controller.dart';
import '../../../export.dart';

class RemoveAds extends StatefulWidget {
  const RemoveAds({Key? key}) : super(key: key);

  @override
  State<RemoveAds> createState() => _RemoveAdsState();
}

class _RemoveAdsState extends State<RemoveAds> {
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
      print(myProducts[0].storeProduct.title.toString());
    } on PlatformException catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    SubsController subsController = Get.find<SubsController>();

    return Container(
      height: Get.height * 0.55,
      width: Get.width,
      color: AppConstants.kAppBlack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Reklamları Kaldır',
            style: TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Purchases.purchasePackage(myProducts[0]).then((value) {
                Get.offAllNamed(NavigationConstants.splash);
              });
            },
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
                    subsController.myProducts[0].storeProduct.title,
                    style: TextStyle(
                      fontFamily: 'Mulish-ExtraBold',
                      fontSize: Get.width * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '₺${subsController.myProducts[0].storeProduct.price.toString()}',
                    style: TextStyle(
                      fontFamily: 'Mulish-ExtraBold',
                      fontSize: Get.width * 0.1,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subsController.myProducts[0].storeProduct.description,
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
          GestureDetector(
            onTap: () async {
              await Purchases.purchasePackage(myProducts[1]);
              Get.offAllNamed(NavigationConstants.splash);
            },
            child: Container(
              width: Get.width * 0.9,
              height: Get.height * 0.2,
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.width * 0.01),
              decoration: BoxDecoration(
                color: AppConstants.kPrimaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    subsController.myProducts[1].storeProduct.title,
                    style: TextStyle(
                      fontFamily: 'Mulish-ExtraBold',
                      fontSize: Get.width * 0.05,
                      color: AppConstants.kAppBlack,
                    ),
                  ),
                  Text(
                    '₺${subsController.myProducts[1].storeProduct.price.toString()}',
                    style: TextStyle(
                      fontFamily: 'Mulish-ExtraBold',
                      fontSize: Get.width * 0.1,
                      color: AppConstants.kAppBlack,
                    ),
                  ),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                        text: subsController.myProducts[1].storeProduct.description,
                        style: TextStyle(
                          fontFamily: 'Mulish-ExtraBold',
                          fontSize: Get.width * 0.04,
                          color: AppConstants.kAppBlack,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
