import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../controllers/future/future_controller.dart';
import '../../../controllers/home_search/home_search_controller.dart';
import '../../../controllers/mini_player/mini_player_controller.dart';
import '../../../controllers/subscription/subscription_controller.dart';
import '../../../controllers/tops/weekly_top_controller.dart';
import '../../../export.dart';
import '../../../models/music/music_listener_req_model.dart';
import '../../../models/top_rate/top_rated_songs_model.dart';
import '../../../services/music/music_service.dart';
import '../../../services/top_service.dart';
import '../../widgets/native_ad.dart';
import '../../widgets/rate_popup.dart';
import '../../widgets/song_card.dart';
import '../../widgets/song_card_shimmer.dart';
import '../../widgets/youtube_video_player.dart';

class WeeklyTop extends StatelessWidget {
  WeeklyTop({
    Key? key,
  }) : super(key: key);

  WeeklyTopController weeklyTopController = Get.find<WeeklyTopController>();
  HomeSearchController homeSearchController = Get.find<HomeSearchController>();
  FutureContoller futureContoller = Get.find();

  @override
  Widget build(BuildContext context) {
    MiniPlayerController miniPlayerController =
        Get.find<MiniPlayerController>();
    SubsController subsController = Get.find<SubsController>();
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: GetBuilder<FutureContoller>(
          id: 'week',
          init: FutureContoller(),
          builder: (getContext) {
            return FutureBuilder<TopRatedSongsModel>(
                future: TopService()
                    .getWeeklyTopList(2, weeklyTopController.dropDownValue),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : SizedBox(
                          height: (Get.height *
                                  0.158 *
                                  snapshot
                                      .data!.data[0].result!.datas!.length) +
                              (4 * Get.height * 0.21) +
                              (Get.height * 0.07 * 5),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                snapshot.data!.data[0].result!.datas!.length +
                                    1,
                            separatorBuilder: (context, index) {
                              return (index % 2 == 0) &&
                                      index != 0 &&
                                      subsController.currentPlan.value == 0
                                  ? Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Container(
                                          height: Get.height * 0.0015,
                                          width: Get.width * 0.92,
                                          decoration: BoxDecoration(
                                            color: AppConstants.kBoxGrey,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.04),
                                          child: NativeAdWidget(),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Container(
                                          height: Get.height * 0.0015,
                                          width: Get.width * 0.92,
                                          decoration: BoxDecoration(
                                            color: AppConstants.kBoxGrey,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        Container(
                                          height: Get.height * 0.0015,
                                          width: Get.width * 0.92,
                                          decoration: BoxDecoration(
                                            color: AppConstants.kBoxGrey,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                      ],
                                    );
                            },
                            itemBuilder: (context, index) {
                              if (snapshot
                                      .data!.data[0].result!.datas!.length ==
                                  index) {
                                if (index == 0) {
                                  return Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: Get.height * 0.025,
                                          ),
                                          Image.asset(
                                            'assets/images/empty_toprate.png',
                                            width: Get.width * 0.6,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.01,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.04),
                                            child: Text(
                                              'Puan tabloları güncellendi! Hemen sevdiğin şarkıları puanla ve listeleri doldur.',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Mulish-SemiBold',
                                                fontSize: Get.width * 0.04,
                                              ),
                                            ),
                                          )
                                        ],
                                      ));
                                }
                                return getPaginationDropdown(snapshot);
                              }
                              int? myRate;
                              if (snapshot.hasData) {
                                if (snapshot.data!.data[0].result!.datas![index]
                                        .myrate ==
                                    0) {
                                  myRate = null;
                                } else {
                                  myRate = snapshot.data!.data[0].result!
                                      .datas![index].myrate;
                                }
                              }

                              return !snapshot.hasData
                                  ? const SongCardShimmer()
                                  : Obx(() {
                                      return SongCard(
                                        showCrowns: true,
                                        title: snapshot.data!.data[0].result!
                                            .datas![index].songName!,
                                        index:
                                            weeklyTopController.dropDownValue ==
                                                    1
                                                ? index
                                                : -1,
                                        myRate: myRate?.toString(),
                                        addPlaylistButton: () {
                                          MusicService()
                                              .musicListen(
                                            MusicListenerReqModel(
                                              listID: 0,
                                              id: snapshot.data!.data[0].result!
                                                  .datas![index].yMusicID!,
                                              title: snapshot
                                                  .data!
                                                  .data[0]
                                                  .result!
                                                  .datas![index]
                                                  .songName!,
                                              thumbnails: snapshot
                                                  .data!
                                                  .data[0]
                                                  .result!
                                                  .datas![index]
                                                  .thumbnail!,
                                            ),
                                          )
                                              .then((value) {
                                            Get.toNamed(
                                              NavigationConstants.addPlaylist,
                                              arguments: {
                                                "id": snapshot
                                                    .data!
                                                    .data[0]
                                                    .result!
                                                    .datas![index]
                                                    .yMusicID!,
                                                "title": snapshot
                                                    .data!
                                                    .data[0]
                                                    .result!
                                                    .datas![index]
                                                    .songName!,
                                                "thumbnail": snapshot
                                                    .data!
                                                    .data[0]
                                                    .result!
                                                    .datas![index]
                                                    .thumbnail!,
                                              },
                                            );
                                          });
                                        },
                                        ratePopup: RatePopup(
                                          title: snapshot.data!.data[0].result!
                                              .datas![index].songName!,
                                          youtubeID: snapshot.data!.data[0]
                                              .result!.datas![index].yMusicID!,
                                          alreadyRated:
                                              myRate == null ? false : true,
                                          myRate: myRate,
                                          ids: [
                                            'day',
                                            'week',
                                            'month',
                                          ],
                                        ),
                                        totalRate: int.parse(snapshot
                                                    .data!
                                                    .data[0]
                                                    .result!
                                                    .datas![index]
                                                    .totalRate!) >
                                                10000
                                            ? '${(int.parse(snapshot.data!.data[0].result!.datas![index].totalRate!) / 1000).toStringAsFixed(1).trimRight()}K'
                                            : snapshot.data!.data[0].result!
                                                .datas![index].totalRate!,
                                        viewCount: snapshot
                                                    .data!
                                                    .data[0]
                                                    .result!
                                                    .datas![index]
                                                    .viewCount! >
                                                10000
                                            ? '${(snapshot.data!.data[0].result!.datas![index].viewCount! / 1000).toStringAsFixed(1)}K'
                                                .trimRight()
                                            : snapshot.data!.data[0].result!
                                                .datas![index].viewCount!
                                                .toString(),
                                        onTap: () {
                                          weeklyTopController.tappedSoundIndex =
                                              index;
                                          weeklyTopController.tappedVideoIndex =
                                              -1;
                                          miniPlayerController.queueList
                                              .clear();
                                          if (!miniPlayerController.isTapPlay) {
                                            miniPlayerController.isTapPlay =
                                                true;
                                            miniPlayerController.init(snapshot
                                                .data!
                                                .data[0]
                                                .result!
                                                .datas![index]
                                                .yMusicID!);
                                            miniPlayerController.videoID =
                                                snapshot.data!.data[0].result!
                                                    .datas![index].yMusicID!;
                                          } else {
                                            miniPlayerController
                                                .youtubePlayerController.value
                                                .load(snapshot
                                                    .data!
                                                    .data[0]
                                                    .result!
                                                    .datas![index]
                                                    .yMusicID!);
                                            miniPlayerController.videoID =
                                                snapshot.data!.data[0].result!
                                                    .datas![index].yMusicID!;
                                          }
                                          miniPlayerController.title = snapshot
                                              .data!
                                              .data[0]
                                              .result!
                                              .datas![index]
                                              .songName!;
                                          miniPlayerController.imgUrl = snapshot
                                              .data!
                                              .data[0]
                                              .result!
                                              .datas![index]
                                              .thumbnail!;
                                          MusicService().musicListen(
                                            MusicListenerReqModel(
                                              listID: 0,
                                              id: miniPlayerController.videoID,
                                              title: miniPlayerController.title,
                                              thumbnails:
                                                  miniPlayerController.imgUrl,
                                            ),
                                          );
                                        },
                                        widget: weeklyTopController
                                                    .tappedVideoIndex ==
                                                index
                                            ? YoutubeVideoPlayer(
                                                videoId: snapshot
                                                    .data!
                                                    .data[0]
                                                    .result!
                                                    .datas![index]
                                                    .yMusicID!)
                                            : GestureDetector(
                                                onTap: () {
                                                  MusicService().musicListen(
                                                    MusicListenerReqModel(
                                                      listID: 0,
                                                      id: miniPlayerController
                                                          .videoID,
                                                      title:
                                                          miniPlayerController
                                                              .title,
                                                      thumbnails:
                                                          miniPlayerController
                                                              .imgUrl,
                                                    ),
                                                  );
                                                  weeklyTopController
                                                      .tappedVideoIndex = index;
                                                  weeklyTopController
                                                      .tappedSoundIndex = -1;
                                                },
                                                child: Container(
                                                  height: Get.height * 0.125,
                                                  width: Get.width * 0.32,
                                                  child: ClipRRect(
                                                    child: Image.network(
                                                      snapshot
                                                          .data!
                                                          .data[0]
                                                          .result!
                                                          .datas![index]
                                                          .thumbnail!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return SizedBox();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        playButton: weeklyTopController
                                                    .tappedSoundIndex ==
                                                index
                                            ? regularPlayButtons(
                                                miniPlayerController)
                                            : null,
                                        backGroundIndicator: weeklyTopController
                                                        .tappedSoundIndex ==
                                                    index ||
                                                weeklyTopController
                                                        .tappedVideoIndex ==
                                                    index
                                            ? Container(
                                                margin: EdgeInsets.zero,
                                                width: Get.width * 2,
                                                height: Get.height * 0.15,
                                                color: AppConstants.kAppGrey,
                                              )
                                            : null,
                                      );
                                    });
                            },
                          ),
                        );
                });
          }),
    );
  }

  Padding getPaginationDropdown(AsyncSnapshot<TopRatedSongsModel> snapshot) {
    print("pagination!.previousPage  :  " +
        snapshot.data!.data[0].result!.pagination!.previousPage.toString());
    return Padding(
      padding: EdgeInsets.only(right: Get.width * 0.04),
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            snapshot.data!.data[0].result!.pagination!.previousPage == null
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      weeklyTopController.dropDownValue -= 1;
                      homeSearchController.scrollController.animateTo(0.0,
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.ease);
                      //weeklyTopController.update();
                      futureContoller.updatePage(["week"]);
                    },
                    child: SvgPicture.asset('assets/icons/prev.svg')),
            SizedBox(
              width: Get.width * 0.025,
            ),
            Container(
              height: Get.height * 0.03,
              width: Get.width * 0.1,
              decoration: BoxDecoration(
                color: AppConstants.kBoxGrey,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Obx(() {
                  return DropdownButton<int>(
                    value: weeklyTopController.dropDownValue,
                    dropdownColor: AppConstants.kBoxGrey,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Mulish-SemiBold',
                      fontSize: Get.width * 0.04,
                    ),
                    underline: const SizedBox(),
                    icon: SvgPicture.asset('assets/icons/arrow-down.svg'),
                    items: List.generate(
                        snapshot.data!.data[0].result!.pagination!.totalPage!,
                        (index) {
                      return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Mulish-SemiBold',
                              fontSize: Get.width * 0.04,
                            ),
                          ));
                    }),
                    onChanged: ((value) {
                      weeklyTopController.dropDownValue = value;
                      homeSearchController.scrollController.animateTo(0.0,
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.ease);
                      //weeklyTopController.update();
                      futureContoller.updatePage(["week"]);
                    }),
                  );
                }),
              ),
            ),
            snapshot.data!.data[0].result!.pagination!.nextPage == null
                ? const SizedBox()
                : SizedBox(
                    width: Get.width * 0.025,
                  ),
            snapshot.data!.data[0].result!.pagination!.nextPage == null
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      weeklyTopController.dropDownValue += 1;
                      homeSearchController.scrollController.animateTo(0.0,
                          duration: const Duration(milliseconds: 1200),
                          curve: Curves.ease);
                      //weeklyTopController.update();
                      futureContoller.updatePage(["week"]);
                    },
                    child: SvgPicture.asset('assets/icons/forward.svg')),
          ],
        ),
      ),
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
          child: SvgPicture.asset(
            'assets/icons/play.svg',
            color: Colors.white,
            width: Get.width * 0.05,
          ),
        );
    }
  }

  Widget getCrowns(int index) {
    switch (index) {
      case 0:
        return Center(
          child: SvgPicture.asset(
            'assets/icons/crown.svg',
            color: AppConstants.kCrownGold,
          ),
        );
      case 1:
        return Center(
          child: SvgPicture.asset(
            'assets/icons/crown.svg',
            color: AppConstants.kCrownSilver,
          ),
        );
      case 2:
        return Center(
          child: SvgPicture.asset(
            'assets/icons/crown.svg',
            color: AppConstants.kCrownBronze,
          ),
        );
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
