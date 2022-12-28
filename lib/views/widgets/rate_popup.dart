import 'package:html_character_entities/html_character_entities.dart';
import 'package:mfavymusic/controllers/future/future_controller.dart';

import '../../controllers/rate_controller/rate_controller.dart';
import '../../export.dart';
import '../../models/music/rate_music_req_model.dart';
import '../../services/rate_music_service.dart';

class RatePopup extends StatelessWidget {
  const RatePopup({Key? key, required this.title, required this.alreadyRated, this.myRate, required this.youtubeID, required this.ids})
      : super(key: key);

  final String title;
  final String youtubeID;
  final bool alreadyRated;
  final int? myRate;
  final List<String> ids;

  @override
  Widget build(BuildContext context) {
    RateController rateController = Get.put(RateController());
    FutureContoller futureContoller = Get.find<FutureContoller>();
    rateController.tappedIndex = myRate ?? 0;
    return Dialog(
      backgroundColor: Colors.transparent,
      child: alreadyRated
          ? Container(
              width: double.infinity,
              height: Get.height * 0.3,
              decoration: BoxDecoration(
                color: AppConstants.kAppBlack,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Get.width * 0.6,
                    child: RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: title,
                            style: TextStyle(fontFamily: 'Mulish-ExtraBold', fontSize: Get.width * 0.035),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'Puan ver',
                    style: TextStyle(fontFamily: 'Mulish-Medium', fontSize: Get.width * 0.035, color: Colors.white),
                  ),
                  SizedBox(
                    width: Get.width * 0.6,
                    height: Get.height * 0.1,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: Get.width * 0.025,
                        );
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            rateController.tappedIndex = index + 1;
                          },
                          child: Obx(
                            () {
                              return SvgPicture.asset(
                                'assets/icons/star.svg',
                                width: Get.width * 0.1,
                                color: index + 1 <= rateController.tappedIndex ? AppConstants.kStarYellow : Colors.white,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Bir şarkıya aynı gün içinde bir kere puan verilebilir!',
                          style: TextStyle(fontFamily: 'Mulish-ExtraBold', fontSize: Get.width * 0.028),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: Get.height * 0.04,
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                            color: AppConstants.kHintText,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'İptal',
                              style: TextStyle(
                                color: AppConstants.kAppBlack,
                                fontSize: Get.width * 0.04,
                                fontFamily: 'Mulish-Bold',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.06,
                      ),
                      Obx(
                        () {
                          return GestureDetector(
                            onTap: rateController.tappedIndex == 0
                                ? () {}
                                : () {
                                    RateMusicService()
                                        .rateMusic(
                                      RateMusicReqModel(yMusicID: youtubeID, rate: rateController.tappedIndex),
                                    )
                                        .then(
                                      (value) {
                                        if (value.success == -2) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              duration: const Duration(milliseconds: 1200),
                                              content: Container(
                                                height: Get.height * 0.08,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppConstants.kAppGrey.withOpacity(0.8),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/message-question.svg',
                                                        color: Colors.red.shade600,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Bu şarkı daha önce hiç dinlenmemiş. \n Puan vermek için en az bir kere dinlenmesi gerekiyor.',
                                                        maxLines: 2,
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
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        } else if (value.success == 2) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              duration: const Duration(milliseconds: 1200),
                                              content: Container(
                                                height: Get.height * 0.05,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppConstants.kAppGrey.withOpacity(0.8),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/like.svg',
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Puanınız başarı ile güncellendi',
                                                        maxLines: 2,
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
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                    Get.back();
                                  },
                            child: Container(
                              height: Get.height * 0.04,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                color: rateController.tappedIndex == 0 ? AppConstants.kHintText : AppConstants.kPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Gönder',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Get.width * 0.04,
                                    fontFamily: 'Mulish-Bold',
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          : Container(
              width: double.infinity,
              height: Get.height * 0.3,
              decoration: BoxDecoration(
                color: AppConstants.kAppBlack,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: HtmlCharacterEntities.decode(title),
                          style: TextStyle(fontFamily: 'Mulish-ExtraBold', fontSize: Get.width * 0.03),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Puan ver',
                    style: TextStyle(fontFamily: 'Mulish-Medium', fontSize: Get.width * 0.035, color: Colors.white),
                  ),
                  SizedBox(
                    width: Get.width * 0.6,
                    height: Get.height * 0.1,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: Get.width * 0.025,
                        );
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            rateController.tappedIndex = index + 1;
                          },
                          child: Obx(
                            () {
                              const Duration(milliseconds: 600);
                              return SvgPicture.asset(
                                'assets/icons/star.svg',
                                width: Get.width * 0.1,
                                color: index + 1 <= rateController.tappedIndex ? AppConstants.kStarYellow : Colors.white,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: Get.height * 0.04,
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                            color: AppConstants.kHintText,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              'İptal',
                              style: TextStyle(
                                color: AppConstants.kAppBlack,
                                fontSize: Get.width * 0.04,
                                fontFamily: 'Mulish-Bold',
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.06,
                      ),
                      Obx(
                        () {
                          return GestureDetector(
                            onTap: rateController.tappedIndex == 0
                                ? () {}
                                : () {
                                    RateMusicService().rateMusic(RateMusicReqModel(yMusicID: youtubeID, rate: rateController.tappedIndex)).then(
                                      (value) {
                                        if (value.success == -2) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              duration: const Duration(milliseconds: 1200),
                                              content: Container(
                                                height: Get.height * 0.08,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppConstants.kAppGrey.withOpacity(0.8),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/message-question.svg',
                                                        color: Colors.red.shade600,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Bu şarkı daha önce hiç dinlenmemiş. \n Puan vermek için en az bir kere dinlenmesi gerekiyor.',
                                                        maxLines: 2,
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
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        } else if (value.success == 1) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              duration: const Duration(milliseconds: 1200),
                                              content: Container(
                                                height: Get.height * 0.05,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppConstants.kAppGrey.withOpacity(0.8),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/like.svg',
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Puanınız başarı ile kaydedildi',
                                                        maxLines: 2,
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
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        } else if (value.success == 2) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              duration: const Duration(milliseconds: 1200),
                                              content: Container(
                                                height: Get.height * 0.05,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppConstants.kAppGrey.withOpacity(0.8),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/like.svg',
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Puanınız başarı ile güncellendi',
                                                        maxLines: 2,
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
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        }
                                        Get.back();
                                        futureContoller.updatePage(ids);
                                      },
                                    );
                                  },
                            child: Container(
                              height: Get.height * 0.04,
                              width: Get.width * 0.3,
                              decoration: BoxDecoration(
                                color: rateController.tappedIndex == 0 ? AppConstants.kHintText : AppConstants.kPrimaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Gönder',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Get.width * 0.04,
                                    fontFamily: 'Mulish-Bold',
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
