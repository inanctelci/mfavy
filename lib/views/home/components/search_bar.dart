import 'package:flutterframework/export.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Container(
        height: Get.height * 0.07,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppConstants.kAppGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          //TODO : Textfield Gelecek
          children: [
            SizedBox(
              width: Get.width * 0.06,
            ),
            SvgPicture.asset(
              'assets/icons/search.svg',
              height: Get.height * 0.03,
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
            Text(
              'Şarkı ara',
              style: TextStyle(
                color: AppConstants.kHintText,
                fontFamily: 'Mulish-Medium',
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
