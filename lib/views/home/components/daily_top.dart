import '../../widgets/banner_ad.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../controllers/daily_top/daily_top_controller.dart';
import '../../../controllers/mini_player/mini_player_controller.dart';
import '../../../export.dart';
import '../../../models/top_rate/top_rate_model.dart';
import '../../../services/user/daily_top_service.dart';
import '../../widgets/rate_popup.dart';
import '../../widgets/song_card.dart';
import '../../widgets/song_card_shimmer.dart';
import '../../widgets/youtube_video_player.dart';

class DailyTop extends StatelessWidget {
  DailyTop({
    Key? key,
  }) : super(key: key);

  YoutubeAPI youtube = YoutubeAPI("AIzaSyDbQjkg1U7VlxN9WN1Mgtky4JCAEz7fMGo");
  List<YouTubeVideo> videoResult = [];
  DailyTopController dailyController = Get.find<DailyTopController>();
  Future<void> callAPI() async {
    dailyController.isAPIworking = true;
    videoResult = await youtube.search(
      '',
      order: 'relevance',
      videoDuration: 'any',
      regionCode: 'tr',
    );
    dailyController.videoResults = videoResult;
    dailyController.isAPIworking = false;
  }

  @override
  Widget build(BuildContext context) {
    MiniPlayerController miniPlayerController = Get.find<MiniPlayerController>();
    if (dailyController.videoResults.isEmpty) callAPI();
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: FutureBuilder<TopRateModel>(
          future: DailyTopService().getDailyTopList(context),
          builder: (context, snapshot) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              separatorBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      height: Get.height * 0.0015,
                      width: Get.width * 0.92,
                      decoration: BoxDecoration(
                        color: AppConstants.kBoxGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                  ],
                );
              },
              itemBuilder: (context, index) {
                int? myRate;
                if (snapshot.hasData) {
                  if (snapshot.data!.datas[0].result.data[index].myrate == 0) {
                    myRate = null;
                  } else {
                    myRate = snapshot.data!.datas[0].result.data[index].myrate;
                  }
                }

                return !snapshot.hasData
                    ? const SongCardShimmer()
                    : (index % 4 == 0) && index != 0
                        ? const BannerAdWidget()
                        : Obx(() {
                            return SongCard(
                              showCrowns: true,
                              title: snapshot.data!.datas[0].result.data[index].songName,
                              // title: _searchController.videoResults[index].title,
                              videoId: snapshot.data!.datas[0].result.data[index].yMusicID,
                              imgUrl: snapshot.data!.datas[0].result.data[index].thumbnail,
                              myRate: myRate?.toString(),
                              ratePopup: RatePopup(
                                title: snapshot.data!.datas[0].result.data[index].songName,
                                alreadyRated: myRate == null ? false : true,
                                myRate: myRate,
                              ),
                              totalRate: int.parse(snapshot.data!.datas[0].result.data[index].totalRate) > 10000
                                  ? '${(int.parse(snapshot.data!.datas[0].result.data[index].totalRate) / 1000).toStringAsFixed(1).trimRight()}K'
                                  : snapshot.data!.datas[0].result.data[index].totalRate,
                              viewCount: snapshot.data!.datas[0].result.data[index].viewCount > 10000
                                  ? '${(snapshot.data!.datas[0].result.data[index].viewCount / 1000).toStringAsFixed(1)}K'.trimRight()
                                  : snapshot.data!.datas[0].result.data[index].viewCount.toString(),
                              onTap: () {
                                dailyController.tappedSoundIndex = index;
                                dailyController.tappedVideoIndex = -1;
                                miniPlayerController.queueList.clear();
                                if (!miniPlayerController.isTapPlay) {
                                  miniPlayerController.isTapPlay = true;
                                  miniPlayerController.init(snapshot.data!.datas[0].result.data[index].yMusicID);
                                  miniPlayerController.videoID = snapshot.data!.datas[0].result.data[index].yMusicID;
                                } else {
                                  miniPlayerController.youtubePlayerController.value.load(snapshot.data!.datas[0].result.data[index].yMusicID);
                                  miniPlayerController.videoID = snapshot.data!.datas[0].result.data[index].yMusicID;
                                }
                                miniPlayerController.title = snapshot.data!.datas[0].result.data[index].songName;
                                miniPlayerController.imgUrl = snapshot.data!.datas[0].result.data[index].thumbnail;
                              },
                              widget: dailyController.tappedVideoIndex == index
                                  ? YoutubeVideoPlayer(videoId: snapshot.data!.datas[0].result.data[index].yMusicID)
                                  : GestureDetector(
                                      onTap: () {
                                        dailyController.tappedVideoIndex = index;
                                        dailyController.tappedSoundIndex = -1;
                                      },
                                      child: Container(
                                        height: Get.height * 0.125,
                                        width: Get.width * 0.32,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot.data!.datas[0].result.data[index].thumbnail),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                              playButton: dailyController.tappedSoundIndex == index ? regularPlayButtons(miniPlayerController) : null,
                              backGroundIndicator: dailyController.tappedSoundIndex == index || dailyController.tappedVideoIndex == index
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
            );
          }),
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
