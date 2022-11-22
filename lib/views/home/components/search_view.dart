import 'package:flutterframework/controllers/home_search/home_search_controller.dart';
import 'package:flutterframework/controllers/mini_player/mini_player_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/widgets/song_card.dart';
import 'package:flutterframework/views/widgets/song_card_shimmer.dart';
import 'package:flutterframework/views/widgets/youtube_video_player.dart';
import 'package:youtube_api/youtube_api.dart';

class SearchView extends StatelessWidget {
  SearchView({Key? key}) : super(key: key);

  YoutubeAPI youtube = YoutubeAPI("AIzaSyDZaGEqRJiRKB-8dCwX2lQbSeLn_5qMvHo");
  HomeSearchController _searchController = Get.find<HomeSearchController>();
  MiniPlayerController _miniPlayerController = Get.find<MiniPlayerController>();

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
                      return _searchController.isAPIworking ? SongCardShimmer() : const SizedBox();
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
                          ? SongCardShimmer()
                          : SongCard(
                              showCrowns: false,
                              title: _searchController.videoResults[index].title,
                              videoId: _searchController.videoResults[index].id,
                              imgUrl: _searchController.videoResults[index].thumbnail.medium.url,
                              rate: 'rate',
                              watch: 'watch',
                              onTap: () {
                                _miniPlayerController.isTapPlay = true;
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
                                          Align(
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                              'assets/icons/play.svg',
                                            ),
                                          ),
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
