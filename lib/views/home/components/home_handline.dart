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
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
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
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                  child: SvgPicture.asset(
                    'assets/icons/menu.svg',
                  ),
                ),
              ),
              Text(
                'MFavy'.tr,
                style: TextStyle(
                  color: AppConstants.kPrimaryColor,
                  fontFamily: 'Yeseva-One',
                  fontSize: 32,
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset('assets/icons/ads.svg'),
              SizedBox(
                width: 5,
              ),
              Text(
                'Reklam\nİstemiyorum',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppConstants.kPrimaryColor,
                  fontFamily: 'Mulish-Semibold',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
