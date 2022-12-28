import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../controllers/future/future_controller.dart';
import '../../../controllers/home_search/home_search_controller.dart';
import '../../../controllers/mini_player/mini_player_controller.dart';
import '../../../export.dart';
import '../../../models/music/music_listener_req_model.dart';
import '../../../models/yt_search/yt_search_model.dart';
import '../../../models/yt_search/yt_search_req_model.dart';
import '../../../services/music/music_service.dart';
import '../../../services/yt_search/yt_service.dart';
import '../../widgets/rate_popup.dart';
import '../../widgets/song_card.dart';
import '../../widgets/song_card_shimmer.dart';
import '../../widgets/youtube_video_player.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);

  final HomeSearchController _searchController = Get.find<HomeSearchController>();
  final MiniPlayerController miniPlayerController = Get.find<MiniPlayerController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 20 * 0.15 + Get.height * 0.055 * 19,
      child: GetBuilder<FutureContoller>(
          init: FutureContoller(),
          id: 'search',
          builder: (getContext) {
            return Obx(() {
              return FutureBuilder<YtSearchModel>(
                future: YtSearchService().searchYt(
                  data: List.generate(
                    _searchController.videoResult.length,
                    (index) => YtSearchReqModel(
                        id: _searchController.videoResult[index].id ?? '',
                        title: _searchController.videoResult[index].title! ?? '',
                        thumbnails: _searchController.videoResult[index].thumbnail.medium.url! ?? ''),
                  ),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) _searchController.isAPIworking = false;
                  return !snapshot.hasData || _searchController.videoResult.isEmpty
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Obx(
                              () {
                                return _searchController.isAPIworking ? const SongCardShimmer() : const SizedBox();
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: Get.height * 0.02,
                            );
                          },
                          itemCount: 10,
                        )
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            int? myRate;
                            if (snapshot.hasData) {
                              if (snapshot.data!.data[0].arr[index].myrate == 0) {
                                myRate = null;
                              } else {
                                myRate = snapshot.data!.data[0].arr[index].myrate;
                              }
                            }
                            return Obx(
                              () {
                                return _searchController.isAPIworking || snapshot.data!.data[0].arr.isEmpty
                                    ? const SongCardShimmer()
                                    : SongCard(
                                        showCrowns: false,
                                        title: snapshot.data!.data[0].arr[index].title,
                                        // title: _searchController.videoResults[index].title,
                                        viewCount: snapshot.data!.data[0].arr[index].viewCount.toString(),
                                        ratePopup: RatePopup(
                                          title: snapshot.data!.data[0].arr[index].title,
                                          youtubeID: snapshot.data!.data[0].arr[index].id,
                                          alreadyRated: myRate == null ? false : true,
                                          myRate: myRate,
                                          ids: [
                                            'search',
                                          ],
                                        ),
                                        totalRate: snapshot.data!.data[0].arr[index].totalRate.toString(),
                                        myRate: myRate?.toString(),
                                        addPlaylistButton: () {
                                          MusicService()
                                              .musicListen(MusicListenerReqModel(
                                                  listID: 0,
                                                  id: snapshot.data!.data[0].arr[index].id,
                                                  title: snapshot.data!.data[0].arr[index].title,
                                                  thumbnails: snapshot.data!.data[0].arr[index].thumbnails))
                                              .then((value) {
                                            Get.toNamed(
                                              NavigationConstants.addPlaylist,
                                              arguments: {
                                                "id": snapshot.data!.data[0].arr[index].id,
                                                "title": snapshot.data!.data[0].arr[index].title,
                                                "thumbnail": snapshot.data!.data[0].arr[index].thumbnails,
                                              },
                                            );
                                          });
                                        },
                                        onTap: () {
                                          _searchController.tappedSoundIndex = index;
                                          _searchController.tappedVideoIndex = -1;
                                          miniPlayerController.queueList.clear();
                                          if (!miniPlayerController.isTapPlay) {
                                            miniPlayerController.isTapPlay = true;
                                            miniPlayerController.init(snapshot.data!.data[0].arr[index].id);
                                            miniPlayerController.videoID = snapshot.data!.data[0].arr[index].id;
                                          } else {
                                            miniPlayerController.youtubePlayerController.value.load(snapshot.data!.data[0].arr[index].id);
                                            miniPlayerController.videoID = snapshot.data!.data[0].arr[index].id;
                                          }
                                          miniPlayerController.title = snapshot.data!.data[0].arr[index].title;
                                          miniPlayerController.imgUrl = snapshot.data!.data[0].arr[index].thumbnails;
                                          MusicService().musicListen(
                                            MusicListenerReqModel(
                                              listID: 0,
                                              id: miniPlayerController.videoID,
                                              title: miniPlayerController.title,
                                              thumbnails: miniPlayerController.imgUrl,
                                            ),
                                          );
                                        },
                                        widget: _searchController.tappedVideoIndex == index
                                            ? YoutubeVideoPlayer(videoId: snapshot.data!.data[0].arr[index].id)
                                            : GestureDetector(
                                                onTap: () {
                                                  _searchController.tappedSoundIndex = -1;
                                                  _searchController.tappedVideoIndex = index;
                                                  MusicService().musicListen(
                                                    MusicListenerReqModel(
                                                      listID: 0,
                                                      id: snapshot.data!.data[0].arr[index].id,
                                                      title: snapshot.data!.data[0].arr[index].title,
                                                      thumbnails: snapshot.data!.data[0].arr[index].thumbnails,
                                                    ),
                                                  );
                                                  _searchController.tappedVideoIndex = index;
                                                  MusicService().musicListen(
                                                    MusicListenerReqModel(
                                                      listID: 0,
                                                      id: miniPlayerController.videoID,
                                                      title: miniPlayerController.title,
                                                      thumbnails: miniPlayerController.imgUrl,
                                                    ),
                                                  );
                                                },
                                                child: Stack(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Container(
                                                        height: Get.height * 0.125,
                                                        width: Get.width * 0.32,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: ClipRRect(
                                                          child: Image.network(
                                                            snapshot.data!.data[0].arr[index].thumbnails,
                                                            fit: BoxFit.cover,
                                                            errorBuilder: (context, error, stackTrace) {
                                                              return SizedBox();
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        playButton: _searchController.tappedSoundIndex == index ? regularPlayButtons(miniPlayerController) : null,
                                        backGroundIndicator:
                                            _searchController.tappedSoundIndex == index || _searchController.tappedVideoIndex == index
                                                ? Container(
                                                    margin: EdgeInsets.zero,
                                                    width: Get.width * 2,
                                                    height: Get.height * 0.15,
                                                    color: AppConstants.kAppGrey,
                                                  )
                                                : null,
                                      );
                              },
                            );
                          },
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
                          itemCount: snapshot.data!.data[0].arr.length,
                        );
                },
              );
            });
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
}
