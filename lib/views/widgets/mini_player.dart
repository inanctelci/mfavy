import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:mfavymusic/controllers/subscription/subscription_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../controllers/library/library_controller.dart';
import '../../controllers/mini_player/mini_player_controller.dart';
import '../../export.dart';
import '../../models/music/music_listener_req_model.dart';
import '../../services/music/music_service.dart';
import 'ad_helper.dart';

class MiniPlayer extends StatelessWidget {
  MiniPlayer({
    super.key,
  });

  late InterstitialAd interstitialAd;

  var numAttemptLoad;

  loadInterstitial() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdManagerAdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdFailedToLoad: (error) {
          interstitialAd.dispose();
          numAttemptLoad += 1;
          if (numAttemptLoad <= 2) {
            loadInterstitial();
          }
        },
        onAdLoaded: (ad) {
          interstitialAd = ad;
          numAttemptLoad = 0;
        },
      ),
    );
    interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        loadInterstitial();
      },
    );
    interstitialAd.show();
    interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SubsController subsController = Get.find<SubsController>();
    MiniPlayerController miniPlayerController = Get.put<MiniPlayerController>(MiniPlayerController());
    LibraryController libraryController = Get.find<LibraryController>();
    return Obx(
      () {
        return miniPlayerController.isTapPlay
            ? Container(
                width: Get.width * 0.92,
                height: Get.height * 0.075,
                decoration: BoxDecoration(
                  color: AppConstants.kBoxGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Visibility(
                              visible: false,
                              maintainState: true,
                              child: YoutubePlayer(
                                controller: miniPlayerController.youtubePlayerController.value,
                                onReady: () {},
                                onEnded: (metaData) {
                                  if (subsController.currentPlan.value == 0) {
                                    loadInterstitial();
                                    interstitialAd.show();
                                    interstitialAd.dispose();
                                  }
                                  if (miniPlayerController.queueList.isNotEmpty) {
                                    miniPlayerController.playNextSong();
                                    if (miniPlayerController.shuffle) {
                                      miniPlayerController.title = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][0];
                                      miniPlayerController.videoID = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][1];
                                      miniPlayerController.imgUrl = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][2];
                                    } else {
                                      miniPlayerController.title = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][0];
                                      miniPlayerController.videoID = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][1];
                                      miniPlayerController.imgUrl = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][2];
                                    }
                                    miniPlayerController.youtubePlayerController.value.load(miniPlayerController.videoID);
                                    MusicService().musicListen(
                                      MusicListenerReqModel(
                                        listID: miniPlayerController.queueList.isEmpty ? 0 : libraryController.tappedIndex,
                                        id: miniPlayerController.videoID,
                                        title: miniPlayerController.title,
                                        thumbnails: miniPlayerController.imgUrl,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: Get.width * 0.04),
                              height: Get.height * 0.04,
                              width: Get.height * 0.04,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.white),
                              ),
                              child: Image.network(
                                miniPlayerController.imgUrl,
                                fit: BoxFit.cover,
                                errorBuilder: ((context, error, stackTrace) {
                                  return SizedBox();
                                }),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            SizedBox(
                              width: Get.width * 0.5,
                              child: ClipRRect(
                                child: Obx(
                                  () {
                                    return miniPlayerController.queueList.isEmpty
                                        ? Text(
                                            HtmlCharacterEntities.decode(miniPlayerController.title),
                                            overflow: TextOverflow.clip,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Mulish-Medium',
                                            ),
                                          )
                                        : Obx(() {
                                            return Dismissible(
                                              key: miniPlayerController.dismissKey.value,
                                              direction: DismissDirection.horizontal,
                                              resizeDuration: const Duration(milliseconds: 200),
                                              onResize: () {},
                                              onDismissed: (direction) {
                                                miniPlayerController.dismissKey.value = UniqueKey();
                                                if (direction == DismissDirection.endToStart) {
                                                  miniPlayerController.playNextSong();
                                                  if (miniPlayerController.shuffle) {
                                                    miniPlayerController.title =
                                                        miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][0];
                                                    miniPlayerController.videoID =
                                                        miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][1];
                                                    miniPlayerController.imgUrl =
                                                        miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][2];
                                                  } else {
                                                    miniPlayerController.title = miniPlayerController.queueList[miniPlayerController.playingIndex][0];
                                                    miniPlayerController.videoID =
                                                        miniPlayerController.queueList[miniPlayerController.playingIndex][1];
                                                    miniPlayerController.imgUrl =
                                                        miniPlayerController.queueList[miniPlayerController.playingIndex][2];
                                                  }
                                                  miniPlayerController.youtubePlayerController.value.load(miniPlayerController.videoID);
                                                } else {
                                                  miniPlayerController.playPrewSong();
                                                  if (miniPlayerController.shuffle) {
                                                    miniPlayerController.title =
                                                        miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][0];
                                                    miniPlayerController.videoID =
                                                        miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][1];
                                                    miniPlayerController.imgUrl =
                                                        miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][2];
                                                  } else {
                                                    miniPlayerController.title = miniPlayerController.queueList[miniPlayerController.playingIndex][0];
                                                    miniPlayerController.videoID =
                                                        miniPlayerController.queueList[miniPlayerController.playingIndex][1];
                                                    miniPlayerController.imgUrl =
                                                        miniPlayerController.queueList[miniPlayerController.playingIndex][2];
                                                  }
                                                  miniPlayerController.youtubePlayerController.value.load(miniPlayerController.videoID);
                                                }
                                              },
                                              child: AnimatedSwitcher(
                                                reverseDuration: const Duration(milliseconds: 200),
                                                duration: const Duration(milliseconds: 500),
                                                transitionBuilder: (child, animation) => FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    HtmlCharacterEntities.decode(miniPlayerController.title),
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: 'Mulish-Medium',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: Get.width * 0.04),
                          child: Obx(() {
                            return miniPlayerController.queueList.isEmpty
                                ? regularPlayButtons(miniPlayerController)
                                : playlistPlayButtons(miniPlayerController);
                          }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.005,
                    ),
                    SizedBox(
                      width: Get.width * 0.86,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Obx(() {
                          //   return Text(
                          //     _miniPlayerController.positionText,
                          //     style: TextStyle(
                          //       color: Colors.white,
                          //       fontFamily: 'Mulish-SemiBold',
                          //     ),
                          //   );
                          // }),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 1,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 4,
                                  pressedElevation: 6,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 1,
                                ),
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: AppConstants.kAppBlack,
                                thumbColor: AppConstants.kHintText,
                                overlayColor: Colors.white,
                              ),
                              child: Obx(() {
                                return Slider(
                                  min: 0,
                                  max: miniPlayerController.duration == 0 ? 100.0 : miniPlayerController.duration,
                                  value: miniPlayerController.sliderValue ?? 0,
                                  onChanged: (value) {
                                    miniPlayerController.dragValue = value;
                                    miniPlayerController.youtubePlayerController.value.seekTo(
                                      Duration(
                                        seconds: value.toInt(),
                                      ),
                                    );
                                  },
                                );
                              }),
                            ),
                          ),
                          // Text(
                          //   _miniPlayerController.formatDuration(_miniPlayerController.player.value.duration!),
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontFamily: 'Mulish-SemiBold',
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }

  Widget regularPlayButtons(MiniPlayerController miniPlayerController) {
    switch (miniPlayerController.playerState) {
      case PlayerState.playing:
        return GestureDetector(
            onTap: () {
              miniPlayerController.youtubePlayerController.value.pause();
            },
            child: SvgPicture.asset(
              'assets/icons/pause.svg',
              color: Colors.white,
              width: Get.width * 0.05,
            ));
      case PlayerState.paused:
        return GestureDetector(
            onTap: () {
              miniPlayerController.youtubePlayerController.value.play();
            },
            child: SvgPicture.asset(
              'assets/icons/play.svg',
              color: Colors.white,
              width: Get.width * 0.05,
            ));
      case PlayerState.ended:
        return GestureDetector(
          onTap: () {
            miniPlayerController.youtubePlayerController.value.play();
          },
          child: SvgPicture.asset(
            'assets/icons/reload.svg',
            color: Colors.white,
            width: Get.width * 0.05,
          ),
        );
      case PlayerState.buffering:
        return SizedBox(
          height: Get.width * 0.05,
          width: Get.width * 0.05,
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        );
      default:
        return SizedBox(
          height: Get.width * 0.05,
          width: Get.width * 0.05,
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        );
    }
  }

  Widget playlistPlayButtons(MiniPlayerController miniPlayerController) {
    switch (miniPlayerController.playerState) {
      case PlayerState.playing:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                miniPlayerController.playPrewSong();
                if (miniPlayerController.shuffle) {
                  miniPlayerController.title = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][0];
                  miniPlayerController.videoID = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][1];
                  miniPlayerController.imgUrl = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][2];
                } else {
                  miniPlayerController.title = miniPlayerController.queueList[miniPlayerController.playingIndex][0];
                  miniPlayerController.videoID = miniPlayerController.queueList[miniPlayerController.playingIndex][1];
                  miniPlayerController.imgUrl = miniPlayerController.queueList[miniPlayerController.playingIndex][2];
                }
                miniPlayerController.youtubePlayerController.value.load(miniPlayerController.videoID);
              },
              child: SvgPicture.asset(
                'assets/icons/previous.svg',
                color: Colors.white,
                width: Get.width * 0.05,
              ),
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                miniPlayerController.youtubePlayerController.value.pause();
              },
              child: SvgPicture.asset(
                'assets/icons/pause.svg',
                width: Get.width * 0.04,
              ),
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                miniPlayerController.playNextSong();
                if (miniPlayerController.shuffle) {
                  miniPlayerController.title = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][0];
                  miniPlayerController.videoID = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][1];
                  miniPlayerController.imgUrl = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][2];
                } else {
                  miniPlayerController.title = miniPlayerController.queueList[miniPlayerController.playingIndex][0];
                  miniPlayerController.videoID = miniPlayerController.queueList[miniPlayerController.playingIndex][1];
                  miniPlayerController.imgUrl = miniPlayerController.queueList[miniPlayerController.playingIndex][2];
                }
                miniPlayerController.youtubePlayerController.value.load(miniPlayerController.videoID);
              },
              child: SvgPicture.asset(
                'assets/icons/next.svg',
                color: Colors.white,
                width: Get.width * 0.05,
              ),
            ),
          ],
        );
      case PlayerState.paused:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                miniPlayerController.playPrewSong();
                if (miniPlayerController.shuffle) {
                  miniPlayerController.title = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][0];
                  miniPlayerController.videoID = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][1];
                  miniPlayerController.imgUrl = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][2];
                } else {
                  miniPlayerController.title = miniPlayerController.queueList[miniPlayerController.playingIndex][0];
                  miniPlayerController.videoID = miniPlayerController.queueList[miniPlayerController.playingIndex][1];
                  miniPlayerController.imgUrl = miniPlayerController.queueList[miniPlayerController.playingIndex][2];
                }
                miniPlayerController.youtubePlayerController.value.load(miniPlayerController.videoID);
              },
              child: SvgPicture.asset(
                'assets/icons/previous.svg',
                color: Colors.white,
                width: Get.width * 0.05,
              ),
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                miniPlayerController.youtubePlayerController.value.play();
              },
              child: SvgPicture.asset(
                'assets/icons/play.svg',
                width: Get.width * 0.04,
              ),
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            GestureDetector(
              onTap: () {
                miniPlayerController.playNextSong();
                if (miniPlayerController.shuffle) {
                  miniPlayerController.title = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][0];
                  miniPlayerController.videoID = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][1];
                  miniPlayerController.imgUrl = miniPlayerController.shuffledQueueList[miniPlayerController.playingIndex][2];
                } else {
                  miniPlayerController.title = miniPlayerController.queueList[miniPlayerController.playingIndex][0];
                  miniPlayerController.videoID = miniPlayerController.queueList[miniPlayerController.playingIndex][1];
                  miniPlayerController.imgUrl = miniPlayerController.queueList[miniPlayerController.playingIndex][2];
                }
                miniPlayerController.youtubePlayerController.value.load(miniPlayerController.videoID);
              },
              child: SvgPicture.asset(
                'assets/icons/next.svg',
                color: Colors.white,
                width: Get.width * 0.05,
              ),
            ),
          ],
        );
      case PlayerState.ended:
        return GestureDetector(
          onTap: () {
            miniPlayerController.youtubePlayerController.value.play();
          },
          child: SvgPicture.asset(
            'assets/icons/reload.svg',
            color: Colors.white,
          ),
        );
      case PlayerState.buffering:
        return SizedBox(
          width: Get.width * 0.18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.width * 0.05,
                width: Get.width * 0.05,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ],
          ),
        );
      default:
        return SizedBox(
          width: Get.width * 0.18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.width * 0.05,
                width: Get.width * 0.05,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ],
          ),
        );
    }
  }
}
