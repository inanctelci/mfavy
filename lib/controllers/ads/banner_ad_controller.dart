import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../export.dart';
import '../../views/widgets/ad_helper.dart';

class BannerAdController extends GetxController {
  late BannerAd bannerAd;
  RxBool isLoaded = false.obs;

  init() {
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.fluid,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          isLoaded.value = true;
          update();
        },
        onAdFailedToLoad: (ad, err) {
          isLoaded.value = false;
          update();
        },
      ),
    );
    bannerAd.load();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }
}
