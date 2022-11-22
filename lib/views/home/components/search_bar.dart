import 'package:flutterframework/controllers/home_search/home_search_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:youtube_api/youtube_api.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeSearchController _searchController = Get.find();
    final TextEditingController textController = _searchController.textController;
    FocusNode _focusNode = FocusNode();

    bool typing = false;
    final String key = 'AIzaSyCHkfkg1Un-Mp6Epkhiq8dECYj8VRedHFY';
    String header = "What are You looking for?";

    YoutubeAPI youtube = YoutubeAPI("AIzaSyDbQjkg1U7VlxN9WN1Mgtky4JCAEz7fMGo");
    List<YouTubeVideo> videoResult = [];

    Future<void> callAPI() async {
      _searchController.isAPIworking = true;
      print('treu oldu =>>>>>>>> ' + _searchController.isAPIworking.toString());
      videoResult = await youtube.search(
        _searchController.textController.text,
        order: 'relevance',
        videoDuration: 'any',
      );
      _searchController.videoResults = videoResult;
      _searchController.isAPIworking = false;
      print('false oldu =>>>>>>>> ' + _searchController.isAPIworking.toString());
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: TextFormField(
        focusNode: _focusNode,
        controller: textController,
        onTap: () {
          _searchController.isSearching = true;
          // getTrends();
        },
        onChanged: (value) {},
        style: TextStyle(
          fontFamily: 'Mulish-Medium',
          color: AppConstants.kHintText,
          fontSize: Get.width * 0.04,
        ),
        decoration: InputDecoration(
            fillColor: AppConstants.kAppGrey,
            filled: true,
            hintText: 'Şarkı ara',
            hintStyle: TextStyle(
              fontFamily: 'Mulish-Medium',
              color: AppConstants.kHintText,
              fontSize: Get.width * 0.04,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.white),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(Get.width * 0.03),
              child: Obx(
                () {
                  return _searchController.isSearching
                      ? GestureDetector(
                          onTap: () {
                            _searchController.isSearching = false;
                            textController.clear();
                            _focusNode.unfocus();
                          },
                          child: SvgPicture.asset(
                            'assets/icons/arrow-left.svg',
                            color: AppConstants.kHintText,
                          ),
                        )
                      : SvgPicture.asset(
                          'assets/icons/search.svg',
                        );
                },
              ),
            ),
            suffixIcon: Obx(
              () {
                return _searchController.isSearching
                    ? GestureDetector(
                        onTap: () {
                          callAPI();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(Get.width * 0.04),
                          child: Text(
                            'Ara',
                            style: TextStyle(
                              color: AppConstants.kPrimaryColor,
                              fontFamily: 'Mulish-ExtraBold',
                            ),
                          ),
                        ),
                      )
                    : SizedBox();
              },
            )),
      ),
    );
  }
}
