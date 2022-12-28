import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../export.dart';
import 'ad_helper.dart';

class NativeAdWidget extends StatefulWidget {
  NativeAdWidget({super.key});

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  late NativeAd? _nativeAd;
  bool isLoaded = false;

  init() async {
    _nativeAd = await NativeAd(
        adUnitId: AdHelper.nativeAdUnitId,
        factoryId: 'listTile',
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _nativeAd = ad as NativeAd;
              isLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            isLoaded = false;
            print('failed - ' + ad.adUnitId.toString() + error.toString());
            ad.dispose();
            setState(() {});
          },
        ),
        customOptions: {'nonnulable': true});
    _nativeAd?.load();
  }

  @override
  Widget build(BuildContext context) {
    NativeAd? nativeAd = _nativeAd;
    return Container(
      height: Get.height * 0.13,
      alignment: Alignment.center,
      child: isLoaded && nativeAd != null
          ? AdWidget(ad: nativeAd)
          : const Center(
              child: Text('Reklam yükleniyor...'),
            ),
    );
  }

  @override
  void didChangeDependencies() {
    _nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      request: AdRequest(),
      factoryId: 'listTile',
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          setState(() {
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
    )..load();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd?.dispose();
  }
}
