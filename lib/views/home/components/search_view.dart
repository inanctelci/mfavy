import 'package:flutterframework/controllers/home_search/home_search_controller.dart';
import 'package:flutterframework/controllers/mini_player/mini_player_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/song_card.dart';
import 'package:flutterframework/views/widgets/song_card_shimmer.dart';
import 'package:flutterframework/views/widgets/youtube_video_player.dart';
import 'package:html_character_entities/html_character_entities.dart';
import 'package:youtube_api/youtube_api.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);

  YoutubeAPI youtube = YoutubeAPI("AIzaSyDZaGEqRJiRKB-8dCwX2lQbSeLn_5qMvHo");
  final HomeSearchController _searchController = Get.find<HomeSearchController>();
  final MiniPlayerController miniPlayerController = Get.find<MiniPlayerController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height * 10 * 0.17,
      child: Obx(() {
        var videoResults = _searchController.videoResults as List;
        return videoResults.isEmpty
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
                  return Obx(
                    () {
                      return _searchController.isAPIworking
                          ? const SongCardShimmer()
                          : SongCard(
                              showCrowns: false,
                              title: _searchController.videoResults[index].title,
                              // title: _searchController.videoResults[index].title,
                              videoId: _searchController.videoResults[index].id,
                              imgUrl: _searchController.videoResults[index].thumbnail.medium.url,
                              onTap: () {
                                miniPlayerController.queueList.clear();
                                if (!miniPlayerController.isTapPlay) {
                                  miniPlayerController.isTapPlay = true;
                                  miniPlayerController.init(_searchController.videoResults[index].id);
                                  miniPlayerController.videoID = _searchController.videoResults[index].id;
                                } else {
                                  miniPlayerController.youtubePlayerController.value.load(_searchController.videoResults[index].id);
                                  miniPlayerController.videoID = _searchController.videoResults[index].id;
                                }
                                miniPlayerController.title = _searchController.videoResults[index].title;
                                miniPlayerController.imgUrl = _searchController.videoResults[index].thumbnail.medium.url;
                              },
                              widget: _searchController.tappedIndex == index
                                  ? YoutubeVideoPlayer(videoId: _searchController.videoResults[index].id)
                                  : GestureDetector(
                                      onTap: () {
                                        _searchController.tappedIndex = index;
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
                                                image: DecorationImage(
                                                  image: NetworkImage(_searchController.videoResults[index].thumbnail.medium.url),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Align(
                                          //   alignment: Alignment.center,
                                          //   child: Icon(
                                          //     Icons.play_arrow,
                                          //     size: 60,
                                          //     color: Colors.white,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
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
                itemCount: videoResults.length,
              );
      }),
    );
  }
}
