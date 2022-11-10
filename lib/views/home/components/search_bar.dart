import 'package:flutterframework/controllers/home_search/home_search_controller.dart';
import 'package:flutterframework/export.dart';
import 'package:youtube_api/youtube_api.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeSearchController _searchController = Get.find();
    final TextEditingController textController = _searchController.textController;
    FocusNode _focusNode = FocusNode();

    // List<YouTubeVideo> videoResult;
    // YoutubeAPI youtube = YoutubeAPI("AIzaSyDZaGEqRJiRKB-8dCwX2lQbSeLn_5qMvHo");

    // Future<void> callAPI() async {
    //   videoResult = await youtube.search(
    //     _searchController.textController.text,
    //     order: 'relevance',
    //     videoDuration: 'any',
    //   );
    //   videoResult = await youtube.nextPage();
    //   print('titleeeeee ' + videoResult[0].title);
    // }

    // Future<void> getTrends() async {
    //   videoResult = await youtube.getTrends(
    //     regionCode: 'TR',
    //   );
    //   print(videoResult[0].title);
    //   videoResult.map((e) {
    //     _searchController.videoResults = e;
    //   });
    // }

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
                          // callAPI();
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
