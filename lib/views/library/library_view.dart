import '../../controllers/future/future_controller.dart';
import '../../controllers/library/library_controller.dart';
import '../../controllers/mini_player/mini_player_controller.dart';
import '../../controllers/scroll_controller/scroll_controller.dart';
import '../../export.dart';
import '../../models/user_list/create_list_req_model.dart';
import '../../models/user_list/user_lists_model.dart';
import '../../services/list/list_service.dart';
import '../playlist/playlist_view.dart';
import '../widgets/playlist_widget.dart';

class LibraryView extends StatelessWidget {
  LibraryView({Key? key}) : super(key: key);

  LibraryController libraryController = Get.find<LibraryController>();

  @override
  Widget build(BuildContext context) {
    PageController pageController = libraryController.pageController;
    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: GetBuilder<LibraryController>(builder: (context) {
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            LibraryPage(),
            PlaylistView(
              onTapBack: () {
                pageController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);

                libraryController.update();
              },
              listID: libraryController.tappedIndex,
            ),
          ],
        );
      }),
      // bottomNavigationBar: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     MiniPlayer(),
      //     BottomNavBar(),
      //   ],
      // ),
    );
  }
}

class LibraryPage extends StatelessWidget {
  LibraryPage({
    Key? key,
  }) : super(key: key);

  final LibraryController _controller = Get.find();
  final FocusNode _node = FocusNode();
  final MiniPlayerController _miniPlayerController = Get.find();
  FutureContoller futureContoller = Get.find<FutureContoller>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.white,
          ),
        ),
        child: SingleChildScrollView(
          child: GetBuilder<LibraryController>(
              id: 'library_page',
              builder: (getBuliderContext) {
                return FutureBuilder<UserListsModel>(
                  future: ListService().getList(
                    context,
                    _controller.sortOpt,
                  ),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Obx(
                            () {
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
                                  snapshot.data!.data[0].datas!.isEmpty
                                      ? const SizedBox()
                                      : Obx(
                                          () {
                                            return SizedBox(
                                              height: (Get.height * 0.22) * snapshot.data!.data[0].datas!.length,
                                              width: Get.width * 0.92,
                                              child: _controller.isGridTapped
                                                  ? GridView.extent(
                                                      childAspectRatio: 1,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      maxCrossAxisExtent: Get.width * 0.5,
                                                      mainAxisSpacing: Get.height * 0.06,
                                                      crossAxisSpacing: Get.width * 0.08,
                                                      children: List.generate(
                                                        snapshot.data!.data[0].datas!.length,
                                                        (index) => LibraryListItem(
                                                          onTap: () {
                                                            _controller.tappedIndex = snapshot.data!.data[0].datas![index].id;
                                                            _controller.tappedListName = snapshot.data!.data[0].datas![index].listName;
                                                            _controller.tappedListImg = snapshot.data!.data[0].datas![index].thumbnail;
                                                            _controller.pageController
                                                                .animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                                            futureContoller.updatePage(['playlist']);
                                                          },
                                                          isGrid: true,
                                                          img: snapshot.data!.data[0].datas![index].thumbnail == "."
                                                              ? Image.asset(
                                                                  'assets/images/playlist.png',
                                                                  fit: BoxFit.cover,
                                                                )
                                                              : Image.network(
                                                                  snapshot.data!.data[0].datas![index].thumbnail!,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                          title: Obx(
                                                            () {
                                                              return _miniPlayerController.playingPlaylistIndex ==
                                                                      snapshot.data!.data[0].datas![index].id
                                                                  ? Text(
                                                                      snapshot.data!.data[0].datas![index].listName!,
                                                                      style: TextStyle(
                                                                        fontFamily: 'Mulish-ExtraBold',
                                                                        color: AppConstants.kPrimaryColor,
                                                                        fontSize: Get.width * 0.04,
                                                                      ),
                                                                    )
                                                                  : Text(
                                                                      snapshot.data!.data[0].datas![index].listName!,
                                                                      style: TextStyle(
                                                                        fontFamily: 'Mulish-Medium',
                                                                        color: Colors.white,
                                                                        fontSize: Get.width * 0.04,
                                                                      ),
                                                                    );
                                                            },
                                                          ),
                                                        ),
                                                      ))
                                                  : ListView.separated(
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, index) {
                                                        return LibraryListItem(
                                                          onTap: () {
                                                            _controller.tappedIndex = snapshot.data!.data[0].datas![index].id;
                                                            _controller.tappedListName = snapshot.data!.data[0].datas![index].listName;
                                                            _controller.tappedListImg = snapshot.data!.data[0].datas![index].thumbnail;
                                                            _controller.pageController
                                                                .animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                                                            futureContoller.updatePage(['playlist']);
                                                          },
                                                          isGrid: false,
                                                          img: snapshot.data!.data[0].datas![index].thumbnail == "."
                                                              ? Image.asset(
                                                                  'assets/images/playlist.png',
                                                                  fit: BoxFit.cover,
                                                                )
                                                              : Image.network(
                                                                  snapshot.data!.data[0].datas![index].thumbnail!,
                                                                  fit: BoxFit.cover,
                                                                ),
                                                          title: Obx(
                                                            () {
                                                              return _miniPlayerController.playingPlaylistIndex ==
                                                                      snapshot.data!.data[0].datas![index].id
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(right: Get.width * 0.4),
                                                                      child: Text(
                                                                        snapshot.data!.data[0].datas![index].listName!,
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                          fontFamily: 'Mulish-ExtraBold',
                                                                          color: AppConstants.kPrimaryColor,
                                                                          fontSize: Get.width * 0.04,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Padding(
                                                                      padding: EdgeInsets.only(right: Get.width * 0.04),
                                                                      child: Text(
                                                                        snapshot.data!.data[0].datas![index].listName!,
                                                                        maxLines: 2,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                          fontFamily: 'Mulish-Medium',
                                                                          color: Colors.white,
                                                                          fontSize: Get.width * 0.04,
                                                                        ),
                                                                      ),
                                                                    );
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      separatorBuilder: (context, index) {
                                                        return SizedBox(
                                                          height: Get.height * 0.02,
                                                        );
                                                      },
                                                      itemCount: snapshot.data!.data[0].datas!.length,
                                                    ),
                                            );
                                          },
                                        ),
                                ],
                              );
                            },
                          );
                  },
                );
              }),
        ),
      ),
    );
  }
}

class PlaylistViewOptions extends StatelessWidget {
  PlaylistViewOptions({
    Key? key,
  }) : super(key: key);

  final LibraryController _controller = Get.find();

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
                  underline: const SizedBox(),
                  icon: const SizedBox(),
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: AppConstants.kBoxGrey,
                  items: getDropdownItems(),
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

  getDropdownItems() {
    return <String>[
      'En Son Dinlenen',
      'En Yeni Oluşturulan',
      'Alfabetik',
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        onTap: () {
          value == 'Alfabetik'
              ? _controller.sortOpt = 1
              : value == 'En Yeni Oluşturulan'
                  ? _controller.sortOpt = 2
                  : value == 'Alfabetik'
                      ? _controller.sortOpt = 3
                      : _controller.sortOpt = 1;
          _controller.updatePage('library_page');
        },
        child: Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Mulish-Medium',
            fontSize: Get.width * 0.04,
          ),
        ),
      );
    }).toList();
  }
}

class PlaylistHeadLine extends StatelessWidget {
  PlaylistHeadLine({
    Key? key,
    required this.node,
  }) : super(key: key);

  final LibraryController _controller = Get.find();
  final FocusNode node;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
      child: SizedBox(
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
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
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
                                      controller: _textController,
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
                                        focusedBorder: UnderlineInputBorder(
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
                                        onTap: () async {
                                          ListService().createList(CreateListReqModel(listName: _textController.text, thumbnail: ".")).then((value) {
                                            if (value.success == 1) {
                                              Get.back();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  duration: const Duration(milliseconds: 1200),
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
                                                          const SizedBox(
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
                                            } else {
                                              Get.back();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  duration: const Duration(milliseconds: 1200),
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
                                                          SvgPicture.asset(
                                                            'assets/icons/message-question.svg',
                                                            color: Colors.red.shade600,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            'Bir şeyler ters gitti. Lütfen tekrar deneyiniz',
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
                                            }
                                            _controller.updatePage('library_page');
                                          });
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
                  fontSize: Get.width * 0.05,
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

  final TextEditingController _textContoller = TextEditingController();
  final LibraryController _controller = Get.find();
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
          style: const TextStyle(
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
              child: const Icon(
                Icons.close_rounded,
                color: AppConstants.kHintText,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
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
