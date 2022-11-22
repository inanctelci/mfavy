import 'package:flutterframework/export.dart';

class HomeHeadLine extends StatelessWidget {
  const HomeHeadLine({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      height: Get.height * 0.1,
      color: AppConstants.kAppBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.03),
                  child: Icon(
                    Icons.menu_rounded,
                    color: AppConstants.kPrimaryColor,
                  ),
                ),
              ),
              Text(
                'MFavy'.tr,
                style: TextStyle(
                  color: AppConstants.kPrimaryColor,
                  fontFamily: 'Gvtime',
                  fontSize: Get.width * 0.11,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    insetAnimationCurve: Curves.ease,
                    insetPadding: EdgeInsets.zero,
                    alignment: Alignment.bottomCenter,
                    child: RemoveAds(),
                  );
                },
              );
            },
            child: Container(
              width: Get.width * 0.4,
              height: Get.height * 0.04,
              decoration: BoxDecoration(
                color: AppConstants.kPrimaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ads.svg',
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: Get.width * 0.01,
                    ),
                    Text(
                      'Reklamları Kaldır',
                      style: TextStyle(
                        fontFamily: 'Mulish-ExtraBold',
                        color: Colors.white,
                        fontSize: Get.width * 0.03,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RemoveAds extends StatelessWidget {
  const RemoveAds({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.55,
      width: Get.width,
      color: AppConstants.kAppBlack,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Reklamları Kaldır',
            style: TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          Container(
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
                  'Reklamsız (1 AYLIK)',
                  style: TextStyle(
                    fontFamily: 'Mulish-ExtraBold',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '₺4,99',
                  style: TextStyle(
                    fontFamily: 'Mulish-ExtraBold',
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '1 ay boyunca reklamsız müzik keyfinin tadını çıkar. Otomatik yenilenir.',
                  style: TextStyle(
                    fontFamily: 'Mulish-ExtraBold',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
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
                  'Reklamsız (1 YILLIK)',
                  style: TextStyle(
                    fontFamily: 'Mulish-ExtraBold',
                    fontSize: 24,
                    color: AppConstants.kAppBlack,
                  ),
                ),
                Text(
                  '₺49,99',
                  style: TextStyle(
                    fontFamily: 'Mulish-ExtraBold',
                    fontSize: 48,
                    color: AppConstants.kAppBlack,
                  ),
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: '1',
                      style: TextStyle(
                        fontFamily: 'Mulish-ExtraBold',
                        fontSize: 16,
                        color: AppConstants.kAppBlack,
                      ),
                    ),
                    TextSpan(
                      text: ' YIL ',
                      style: TextStyle(
                        fontFamily: 'Mulish-ExtraBold',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: 'boyunca reklamsız müzik keyfinin tadını çıkar. Otomatik yenilenir.',
                      style: TextStyle(
                        fontFamily: 'Mulish-ExtraBold',
                        fontSize: 16,
                        color: AppConstants.kAppBlack,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
