import 'package:html_character_entities/html_character_entities.dart';

import '../../export.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    Key? key,
    this.index,
    required this.showCrowns,
    required this.title,
    this.myRate,
    required this.widget,
    this.onTap,
    this.totalRate,
    this.viewCount,
    this.ratePopup,
    this.playButton,
    this.backGroundIndicator,
    this.addPlaylistButton,
    this.isPlaylist,
  }) : super(key: key);

  final int? index;
  final bool showCrowns;
  final String title;
  final String? myRate;
  final String? totalRate;
  final String? viewCount;
  final Widget widget;
  final VoidCallback? onTap;
  final VoidCallback? addPlaylistButton;
  final Widget? ratePopup;
  final Widget? playButton;
  final Widget? backGroundIndicator;
  final bool? isPlaylist;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.15,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: backGroundIndicator ?? const SizedBox(),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
            child: SizedBox(
              height: Get.height * 0.125,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(children: [
                        Container(
                          height: Get.height * 0.125,
                          width: Get.width * 0.32,
                          decoration: BoxDecoration(
                            color: AppConstants.kAppBlack,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              width: 2,
                              color: AppConstants.kHintText,
                            ),
                          ),
                          child: ClipRRect(borderRadius: BorderRadius.circular(4), child: widget),
                        ),
                        showCrowns
                            ? index == 0
                                ? SvgPicture.asset('assets/icons/gold-medal.svg')
                                : index == 1
                                    ? SvgPicture.asset('assets/icons/silver-medal.svg')
                                    : index == 2
                                        ? SvgPicture.asset('assets/icons/bronze-medal.svg')
                                        : const SizedBox()
                            : const SizedBox(),
                      ]),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      SizedBox(
                        height: Get.height * 0.125,
                        width: Get.width * 0.54,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.054,
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: HtmlCharacterEntities.decode(title),
                                      style: TextStyle(fontFamily: 'Mulish-SemiBold', fontSize: Get.width * 0.035),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                          totalRate ?? '0',
                                          style: TextStyle(fontFamily: 'Mulish-SemiBold', color: Colors.white, fontSize: Get.width * 0.035),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/eye.svg',
                                          height: Get.height * 0.02,
                                          color: AppConstants.kPrimaryColor,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.005,
                                        ),
                                        Text(
                                          viewCount ?? '0',
                                          style: TextStyle(
                                            fontFamily: 'Mulish-SemiBold',
                                            color: Colors.white,
                                            fontSize: Get.width * 0.035,
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
                                            return ratePopup ?? const SizedBox();
                                          },
                                          barrierDismissible: false,
                                        );
                                      },
                                      child: myRate == null
                                          ? Container(
                                              height: Get.width * 0.1,
                                              width: Get.width * 0.1,
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
                                            )
                                          : Container(
                                              height: Get.width * 0.1,
                                              width: Get.width * 0.1,
                                              decoration: BoxDecoration(
                                                color: AppConstants.kBoxGrey,
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: AppConstants.kStarYellow,
                                                  width: 4,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                  Get.width * 0.015,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/icons/star.svg',
                                                  color: AppConstants.kStarYellow,
                                                ),
                                              ),
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: addPlaylistButton,
                                      child: Container(
                                        height: Get.width * 0.1,
                                        width: Get.width * 0.1,
                                        decoration: BoxDecoration(
                                          color: AppConstants.kBoxGrey,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            Get.width * 0.015,
                                          ),
                                          child: isPlaylist == true
                                              ? SvgPicture.asset(
                                                  'assets/icons/music-square-remove.svg',
                                                )
                                              : SvgPicture.asset(
                                                  'assets/icons/music-square-add.svg',
                                                ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: onTap ?? () {},
                                      child: Container(
                                        height: Get.width * 0.1,
                                        width: Get.width * 0.1,
                                        decoration: BoxDecoration(
                                          color: AppConstants.kBoxGrey,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                            Get.width * 0.025,
                                          ),
                                          child: playButton ??
                                              SvgPicture.asset(
                                                'assets/icons/play.svg',
                                              ),
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
                ],
              ),
            ),
          ),
        ),
      ]),
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
            style: const TextStyle(
              fontFamily: 'Mulish-ExtraBold',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        );
    }
  }
}
