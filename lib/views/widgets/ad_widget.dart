import 'package:flutterframework/export.dart';

class AdWidget extends StatelessWidget {
  const AdWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: Get.height * 0.17,
      child: Center(
        child: Text(
          'BU ALANA REKLAM VEREBİLİRSİNİZ',
          style: TextStyle(
            fontFamily: 'Mulish-ExtraBold',
          ),
        ),
      ),
    );
  }
}
