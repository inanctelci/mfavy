import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../export.dart';
import 'ad_helper.dart';

class BannerAdWidget extends StatefulWidget {
  BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd bannerAd;
  bool isLoaded = false;

  init() {
    bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.fluid,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
          isLoaded = true;
          setState(() {});
        },
        onAdFailedToLoad: (ad, err) {
          isLoaded = false;
          setState(() {});
        },
      ),
    );
    bannerAd.load();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("isloaded " + isLoaded.toString());
    // bannerAdController.init();
    return Center(
      child: isLoaded
          ? SizedBox(
              width: Get.width * 0.92,
              height: AdSize.banner.height.toDouble(),
              child: AdWidget(
                ad: bannerAd,
              ),
            )
          : const SizedBox(),
    );
  }
}
