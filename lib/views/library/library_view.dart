import 'package:flutterframework/controllers/library/library_controller.dart';
import 'package:flutterframework/views/widgets/bottom_nav_bar.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

import '../../export.dart';
import '../widgets/playlist_widget.dart';

class LibraryView extends StatelessWidget {
  LibraryView({Key? key}) : super(key: key);

  LibraryController _controller = Get.find();
  FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.04,
                ),
                _controller.isSearching
                    ? PlaylistSearchBar(
                        node: _node,
                      )
                    : Column(
                        children: [
                          PlaylistHeadLine(
                            node: _node,
                          ),
                          SizedBox(
                            height: Get.height * 0.04,
                          ),
                          PlaylistViewOptions(),
                        ],
                      ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Obx(() {
                  return Container(
                      height: (Get.height * 0.22) * 12,
                      width: Get.width * 0.92,
                      child: _controller.isGridTapped
                          ? GridView.extent(
                              childAspectRatio: 1,
                              physics: NeverScrollableScrollPhysics(),
                              maxCrossAxisExtent: Get.width * 0.5,
                              mainAxisSpacing: Get.height * 0.06,
                              crossAxisSpacing: Get.width * 0.08,
                              children: List.generate(
                                10,
                                (index) => PlaylistWidget(
                                    onTap: () {
                                      Get.toNamed(NavigationConstants.playlist);
                                    },
                                    isGrid: true),
                              ),
                            )
                          : ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return PlaylistWidget(
                                  isGrid: false,
                                  onTap: () {
                                    Get.toNamed(NavigationConstants.playlist);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: Get.height * 0.02,
                                );
                              },
                              itemCount: 12,
                            ));
                }),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class PlaylistViewOptions extends StatelessWidget {
  PlaylistViewOptions({
    Key? key,
  }) : super(key: key);

  LibraryController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.04,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/sort-by.svg'),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Obx(() {
                return DropdownButton<String>(
                  focusColor: Colors.white,
                  value: _controller.sortBy,
                  borderRadius: BorderRadius.circular(4),
                  elevation: 0,
                  underline: SizedBox(),
                  icon: SizedBox(),
                  style: TextStyle(color: Colors.white),
                  dropdownColor: AppConstants.kBoxGrey,
                  items: <String>[
                    'En Yakın Tarihli',
                    'En Son Dinlenen',
                    'En Yeni eklenen',
                    'Alfabetik',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Mulish-Medium',
                          fontSize: Get.width * 0.04,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    _controller.sortBy = value;
                  },
                );
              }),
            ],
          ),
          Obx(() {
            return GestureDetector(
              onTap: () {
                _controller.isGridTapped = !_controller.isGridTapped;
              },
              child: _controller.isGridTapped
                  ? SvgPicture.asset(
                      'assets/icons/grid-rows.svg',
                      width: Get.width * 0.05,
                    )
                  : SvgPicture.asset(
                      'assets/icons/grid-square.svg',
                      width: Get.width * 0.05,
                    ),
            );
          }),
          // SvgPicture.asset('assets/icons/grid-square.svg'),
        ],
      ),
    );
  }
}

class PlaylistHeadLine extends StatelessWidget {
  PlaylistHeadLine({
    Key? key,
    required this.node,
  }) : super(key: key);

  LibraryController _controller = Get.find();
  final FocusNode node;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: Container(
        height: Get.height * 0.03,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _controller.isSearching = true;
                      node.requestFocus();
                    },
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: Get.width * 0.06,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                              width: Get.width,
                              height: Get.height * 0.2,
                              decoration: BoxDecoration(
                                color: AppConstants.kAppBlack,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Çalma listesine bir isim ver',
                                    style: TextStyle(
                                      fontFamily: 'Mulish-ExtraBold',
                                      color: Colors.white,
                                      fontSize: Get.width * 0.035,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.6,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Get.width * 0.03,
                                        fontFamily: 'Mulish-Medium',
                                      ),
                                      cursorColor: Colors.white,
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        focusedBorder: const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: AppConstants.kHintText,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'İptal',
                                              style: TextStyle(
                                                color: AppConstants.kAppBlack,
                                                fontSize: Get.width * 0.04,
                                                fontFamily: 'Mulish-Bold',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.06,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Container(
                                                height: Get.height * 0.05,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: AppConstants.kAppGrey.withOpacity(0.8),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset('assets/icons/like.svg'),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        'Çalma Listesi Oluşturuldu.',
                                                        style: TextStyle(
                                                          fontFamily: 'Mulish-ExtraBold',
                                                          color: Colors.white,
                                                          fontSize: Get.width * 0.03,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              backgroundColor: Colors.transparent,
                                              elevation: 0,
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: Get.height * 0.04,
                                          width: Get.width * 0.3,
                                          decoration: BoxDecoration(
                                            color: AppConstants.kPrimaryColor,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Oluştur',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Get.width * 0.04,
                                                fontFamily: 'Mulish-Bold',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: SvgPicture.asset(
                      'assets/icons/add.svg',
                      width: Get.width * 0.06,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Listelerim',
                style: TextStyle(
                  fontFamily: 'Mulish-ExtraBold',
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistSearchBar extends StatelessWidget {
  PlaylistSearchBar({Key? key, required this.node}) : super(key: key);

  TextEditingController _textContoller = TextEditingController();
  LibraryController _controller = Get.find();
  final FocusNode node;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
        ),
        child: TextFormField(
          focusNode: node,
          controller: _textContoller,
          cursorColor: Colors.white,
          style: TextStyle(
            fontFamily: 'Mulish-Medium',
            color: Colors.white,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppConstants.kAppGrey,
            prefixIcon: Padding(
              padding: EdgeInsets.all(Get.width * 0.035),
              child: SvgPicture.asset(
                'assets/icons/search.svg',
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                _controller.isSearching = false;
              },
              child: Icon(
                Icons.close_rounded,
                color: AppConstants.kHintText,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
