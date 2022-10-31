import 'package:flutterframework/export.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppConstants.kAppBlack,
      width: Get.width * 0.7,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.06,
          vertical: Get.height * 0.06,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MFavy'.tr,
              style: TextStyle(
                color: AppConstants.kPrimaryColor,
                fontFamily: 'Yeseva-One',
                fontSize: Get.width * 0.08,
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/share.svg',
                  color: Colors.white,
                  width: Get.width * 0.08,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Text(
                  'Uygulamayı paylaş',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-Bold',
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/medal-star.svg',
                  color: Colors.white,
                  width: Get.width * 0.08,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Text(
                  'Puan Ver',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-Bold',
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/mail.svg',
                  color: Colors.white,
                  width: Get.width * 0.08,
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                Text(
                  'İletişim',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Mulish-Bold',
                    fontSize: Get.width * 0.035,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
