import '../../export.dart';

class NativeAdController extends GetxController {
  // late NativeAd _nativeAd;
  // RxBool isLoaded = false.obs;

  // init() {
  //   _nativeAd = NativeAd(
  //     adUnitId: AdHelper.nativeAdUnitId,
  //     factoryId: 'listTile',
  //     request: const AdRequest(),
  //     listener: NativeAdListener(
  //       onAdLoaded: (ad) {
  //         _nativeAd = ad as NativeAd;
  //         isLoaded.value = true;
  //         update();
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         isLoaded.value = false;
  //         print('failed - ' + ad.adUnitId.toString() + error.toString());
  //         _nativeAd.dispose();
  //       },
  //     ),
  //   );
  //   _nativeAd.load();
  // }

  // @override
  // void onInit() {
  //   init();
  //   super.onInit();
  // }

  // get nativeAd => _nativeAd;
  // set nativeAd(value) => _nativeAd = value;
}
