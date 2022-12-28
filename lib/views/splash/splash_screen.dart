import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../controllers/subscription/subscription_controller.dart';
import '../../export.dart';
import '../../models/user/user_register_req_model.dart';
import '../widgets/ad_helper.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  SubsController subsController = Get.find<SubsController>();

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  final storage = const FlutterSecureStorage();

  late RewardedAd rewardedAd;

  loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdManagerAdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          rewardedAd = ad;
        },
        onAdFailedToLoad: (error) {
          rewardedAd.dispose();
          loadRewardedAd();
        },
      ),
    );

    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: ((ad, error) {
        ad.dispose();
        loadRewardedAd();
      }),
    );
    rewardedAd.show(
      onUserEarnedReward: (ad, reward) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    subsController.init();
    subsController.initPlatformState();
    Timer.periodic(
      const Duration(
        minutes: 6,
      ),
      (timer) async {
        if (subsController.currentPlan.value == 0) {
          await loadRewardedAd();
        }
      },
    );

    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: FutureBuilder<String?>(
          future: _getId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserService()
                  .registerUser(
                UserRegisterReqModel(device: snapshot.data!),
              )
                  .then((value) {
                if (value.success == 1) {
                  Get.offAllNamed(NavigationConstants.onboard);
                  storage.write(key: "accessToken", value: value.data[0].accessToken);
                } else {
                  UserService().loginUser(UserRegisterReqModel(device: snapshot.data!)).then((value) {
                    if (value.success == 1) {
                      Get.offAllNamed(NavigationConstants.navigation);
                      storage.write(key: "accessToken", value: value.data[0].tokens.accessToken);
                    } else {}
                  });
                }
              });
            }

            return Center(
              child: SizedBox(
                height: Get.height * 0.4,
                child: Stack(
                  children: [
                    const Align(
                        alignment: Alignment.bottomCenter,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/music.png',
                        width: Get.width * 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
