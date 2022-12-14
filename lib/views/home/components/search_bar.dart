import 'package:http/http.dart' as http;
import 'package:substring_highlight/substring_highlight.dart';
import 'package:youtube_api/youtube_api.dart';

import '../../../controllers/home_search/home_search_controller.dart';
import '../../../controllers/tops/daily_top_controller.dart';
import '../../../controllers/tops/monthly_top_controller.dart';
import '../../../controllers/tops/weekly_top_controller.dart';
import '../../../export.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeSearchController searchController = Get.find();
    FocusNode externalFocusNode = FocusNode();

    List<YouTubeVideo> videoResult = [];
    List<dynamic>? autoComplete;
    Future<void> autoCompleteSuggestions(String text) async {
      var getSuggestions = await http.get(Uri.parse('http://suggestqueries.google.com/complete/search?client=youtube&ds=yt&client=firefox&q=$text'));
      final extractedData = json.decode(getSuggestions.body) as List<dynamic>;
      autoComplete = extractedData;
    }

    YoutubeAPI youtube = YoutubeAPI(
      "AIzaSyAYJd9TWaVhga7sac9uzSTw4LjEKREmhiE",
      maxResults: 20,
    );
    Future<void> callAPI() async {
      searchController.isAPIworking = true;
      videoResult = await youtube.search(
        searchController.textController.text,
        order: 'relevance',
        videoDuration: 'any',
        regionCode: 'tr',
      );
      searchController.videoResult.value = videoResult;
      searchController.tappedVideoIndex = (-1);
      searchController.tappedSoundIndex = (-1);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: RawAutocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          } else {
            if ((autoComplete?[1] as List<dynamic>).isEmpty) {
              return const Iterable<String>.empty();
            } else {
              return (autoComplete![1] as List<dynamic>).map((e) => e.toString()).toList();
            }
          }
        },
        onSelected: (String selection) {},
        fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
          searchController.textController = textEditingController;
          externalFocusNode = focusNode;
          return TextFormField(
            keyboardType: TextInputType.text,
            cursorColor: Colors.white,
            focusNode: focusNode,
            controller: textEditingController,
            onTap: () {
              searchController.isSearching = true;
              // getTrends();
            },
            onChanged: ((value) {
              autoCompleteSuggestions(value);
              // setState(() {});
            }),
            onFieldSubmitted: (val) {
              callAPI();
              focusNode.unfocus();
            },
            style: TextStyle(
              fontFamily: 'Mulish-Medium',
              color: AppConstants.kHintText,
              fontSize: Get.width * 0.04,
            ),
            decoration: InputDecoration(
                fillColor: AppConstants.kAppGrey,
                filled: true,
                hintText: '??ark?? ara',
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
                  borderSide: const BorderSide(color: Colors.white),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(Get.width * 0.03),
                  child: Obx(
                    () {
                      return searchController.isSearching
                          ? GestureDetector(
                              onTap: () {
                                searchController.isSearching = false;
                                textEditingController.clear();
                                focusNode.unfocus();
                                WeeklyTopController().update();
                                DailyTopController().update();
                                MonthlyTopController().update();
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
                    return searchController.isSearching
                        ? GestureDetector(
                            onTap: () {
                              callAPI();
                              focusNode.unfocus();
                            },
                            child: Padding(
                              padding: EdgeInsets.all(Get.width * 0.04),
                              child: const Text(
                                'Ara',
                                style: TextStyle(
                                  color: AppConstants.kPrimaryColor,
                                  fontFamily: 'Mulish-ExtraBold',
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                )),
          );
        },
        optionsViewBuilder: (BuildContext context, void Function(String) onSelected, Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              borderRadius: BorderRadius.circular(4),
              color: AppConstants.kAppGrey,
              child: SizedBox(
                width: Get.width * 0.94,
                height: Get.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: options.map((opt) {
                      return InkWell(
                        onTap: () {
                          onSelected(opt);
                          searchController.textController.text = opt;
                          externalFocusNode.unfocus();
                          callAPI();
                        },
                        child: ListTile(
                          title: SubstringHighlight(
                            text: opt.toString(),
                            term: searchController.textController.text,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Mulish-SemiBold',
                            ),
                            textStyleHighlight: const TextStyle(
                              color: AppConstants.kPrimaryColor,
                              fontFamily: 'Mulish-ExtraBold',
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
