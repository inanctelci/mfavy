import 'package:flutterframework/controllers/rate_controller/rate_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/rate_popup.dart';

class SongCard extends StatelessWidget {
  SongCard({
    Key? key,
    this.index,
    required this.showCrowns,
  }) : super(key: key);

  int? index;
  final bool showCrowns;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
      child: Row(
        children: [
          // showCrowns
          //     ? Container(
          //         width: Get.width * 0.06,
          //         child: Center(
          //           child: Text(
          //             (index! + 1).toString(),
          //             style: TextStyle(
          //               fontFamily: 'Mulish-ExtraBold',
          //               fontSize: Get.width * 0.04,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //       )
          //     : const SizedBox(),
          Stack(children: [
            Container(
              height: Get.height * 0.125,
              width: Get.width * 0.32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: AssetImage('assets/images/ebrugundes.png'), fit: BoxFit.cover),
              ),
            ),
            index == 0 || index == 1 || index == 2
                ? SvgPicture.asset(
                    index == 0
                        ? 'assets/icons/medal-gold.svg'
                        : index == 1
                            ? 'assets/icons/medal-silver.svg'
                            : index == 2
                                ? 'assets/icons/medal-bronze.svg'
                                : '',
                    width: Get.width * 0.08,
                  )
                : const SizedBox(),
          ]),
          SizedBox(
            width: Get.width * 0.02,
          ),
          Container(
            height: Get.height * 0.125,
            width: showCrowns ? Get.width * 0.48 : Get.width * 0.54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * 0.054,
                  child: RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Ebru Gündeş',
                          style: TextStyle(fontFamily: 'Mulish-ExtraBold', fontSize: Get.width * 0.035),
                        ),
                        TextSpan(
                          text: ' - ',
                          style: TextStyle(fontFamily: 'Mulish-Medium', fontSize: Get.width * 0.035),
                        ),
                        TextSpan(
                          text: 'Demir attım yalnızlığa',
                          style: TextStyle(fontFamily: 'Mulish-Medium', fontSize: Get.width * 0.035),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/star.svg',
                              height: Get.height * 0.018,
                              color: AppConstants.kStarYellow,
                            ),
                            SizedBox(
                              width: Get.width * 0.005,
                            ),
                            Text(
                              '120K',
                              style: TextStyle(fontFamily: 'Mulish-SemiBold', color: Colors.white, fontSize: Get.width * 0.03),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/eye.svg',
                              height: Get.height * 0.02,
                            ),
                            SizedBox(
                              width: Get.width * 0.005,
                            ),
                            Text(
                              '120K',
                              style: TextStyle(
                                fontFamily: 'Mulish-SemiBold',
                                color: Colors.white,
                                fontSize: Get.width * 0.03,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: RatePopup(),
                                );
                              },
                              barrierDismissible: false,
                            );
                          },
                          child: Container(
                            height: Get.width * 0.08,
                            width: Get.width * 0.08,
                            decoration: BoxDecoration(
                              color: AppConstants.kBoxGrey,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                Get.width * 0.015,
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/star.svg',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: Get.width * 0.08,
                          width: Get.width * 0.08,
                          decoration: BoxDecoration(
                            color: AppConstants.kBoxGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              Get.width * 0.015,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/music-square-add.svg',
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: Get.width * 0.08,
                          width: Get.width * 0.08,
                          decoration: BoxDecoration(
                            color: AppConstants.kBoxGrey,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              Get.width * 0.015,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/play.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getCrowns(int index) {
    switch (index) {
      // case 0:
      //   return Center(
      //     child: SvgPicture.asset(
      //       'assets/icons/crown.svg',
      //       color: AppConstants.kCrownGold,
      //     ),
      //   );
      // case 1:
      //   return Center(
      //     child: SvgPicture.asset(
      //       'assets/icons/crown.svg',
      //       color: AppConstants.kCrownSilver,
      //     ),
      //   );
      // case 2:
      //   return Center(
      //     child: SvgPicture.asset(
      //       'assets/icons/crown.svg',
      //       color: AppConstants.kCrownBronze,
      //     ),
      //   );
      default:
        return Center(
          child: Text(
            (index + 1).toString(),
            style: TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        );
    }
  }
}
