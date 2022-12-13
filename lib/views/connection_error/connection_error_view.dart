import 'package:flutterframework/export.dart';

class ConnectionErrorView extends StatelessWidget {
  ConnectionErrorView({Key? key}) : super(key: key);

  final ConnectionController connectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/connection_error.png',
              width: Get.width * 0.6,
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Text(
              'Bağlantı Yok',
              style: TextStyle(fontFamily: 'Mulish-ExtraBold', color: Colors.white, fontSize: Get.width * 0.05),
            ),
            SizedBox(
              height: Get.height * 0.025,
            ),
            SizedBox(
              width: Get.width * 0.8,
              child: Text(
                'Görünüşe göre internet bağlantınız yok, lütfen bağlantınızı kontrol edip tekrar deneyiniz...',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Mulish-SemiBold', color: Colors.white, fontSize: Get.width * 0.03),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            ElevatedButton(
              onPressed: () {
                connectionController.checkConnection();
              },
              child: Text(
                'Tekrar Dene',
                style: TextStyle(
                  fontFamily: 'Mulish-Bold',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
