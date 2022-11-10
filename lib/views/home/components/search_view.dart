import 'package:flutterframework/controllers/home_search/home_search_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/library/library_view.dart';
import 'package:flutterframework/views/widgets/song_card.dart';
import 'package:youtube_api/youtube_api.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeSearchController _controller = Get.find();
    print(_controller.videoResults.toString());
    // List<YouTubeVideo> videos = _controller.videoResults;
    return Container(
      width: Get.width,
      height: Get.height * 1.6,
      child: Obx(
        () {
          return ListView.separated(
              itemBuilder: (context, index) {
                return SongCard(
                  showCrowns: false,
                  title: _controller.videoResults[0].title,
                  imgUrl: _controller.videoResults[0].thumbnail.medium.url ?? '',
                  rate: 'rate',
                  watch: 'watch',
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: Get.height * 0.02,
                );
              },
              itemCount: _controller.videoResults.length);
        },
      ),
    );
  }
}
