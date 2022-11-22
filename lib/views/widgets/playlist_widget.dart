import 'package:flutterframework/export.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({
    Key? key,
    required this.onTap,
    required this.isGrid,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: isGrid
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.width * 0.36,
                  width: Get.width * 0.42,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/ebrugundes.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  'Türkçe Pop Listem',
                  style: TextStyle(
                    fontFamily: 'Mulish-SemiBold',
                    fontSize: Get.width * 0.03,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : Row(
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
    );
  }
}
