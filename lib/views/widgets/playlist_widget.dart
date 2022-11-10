import 'package:flutterframework/export.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.04,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: Get.width * 0.1,
                      width: Get.width * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/ebrugundes.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: Get.width * 0.1,
                      width: Get.width * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ebrugundes.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: Get.width * 0.1,
                      width: Get.width * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ebrugundes.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: Get.width * 0.1,
                      width: Get.width * 0.1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ebrugundes.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: Get.width * 0.04,
            ),
            Text(
              'Türkçe Pop Listem',
              style: TextStyle(
                fontFamily: 'Mulish-Medium',
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
