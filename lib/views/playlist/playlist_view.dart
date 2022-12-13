import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../controllers/library/library_controller.dart';
import '../../controllers/mini_player/mini_player_controller.dart';
import '../../controllers/scroll_controller/scroll_controller.dart';
import '../../export.dart';
import '../../models/music_list/music_list_model.dart';
import '../../services/user/list_service.dart';
import '../widgets/rate_popup.dart';
import '../widgets/song_card.dart';
import '../widgets/youtube_video_player.dart';

class PlaylistView extends StatelessWidget {
  PlaylistView({
    Key? key,
    required this.onTapBack,
    required this.listID,
  }) : super(key: key);

  final FocusNode _node = FocusNode();
  final VoidCallback onTapBack;
  final int listID;

  @override
  Widget build(BuildContext context) {
    PlaylistScrollController playlistScrollController = Get.put<PlaylistScrollController>(PlaylistScrollController());
    var textController = playlistScrollController.textController as TextEditingController;
    MiniPlayerController miniPlayerController = Get.find<MiniPlayerController>();
    LibraryController libraryController = Get.find<LibraryController>();

    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      body: FutureBuilder<MusicListModel>(
          future: ListService().getList(context),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.04,
                        ),
                        child: Column(
                          children: [
                            Opacity(
                              opacity: playlistScrollController.imageOpacity.clamp(0, 1.0),
                              child: Center(
                                child: Obx(
                                  () {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        top: Get.height * 0.02,
                                      ),
                                      width: playlistScrollController.imageSize,
                                      height: playlistScrollController.imageSize,
                                      child: Image.network(
                                        snapshot.data!.datas[0].data[libraryController.tappedIndex].thumbnail,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        controller: playlistScrollController.controller,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              width: Get.width,
                              child: Padding(
                                padding: EdgeInsets.only(top: Get.height * 0.08),
                                child: Column(
                                  children: [
                                    SizedBox(height: playlistScrollController.initialSize),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Obx(() {
                                            return Text(
                                              snapshot.data!.datas[0].data[libraryController.tappedIndex].listName,
                                              style: TextStyle(
                                                fontFamily: 'Mulish-Medium',
                                                color: Colors.white,
                                                fontSize: Get.width * 0.05,
                                              ),
                                            );
                                          }),
                                          SizedBox(
                                            height: Get.height * 0.05,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.06,
                                                width: Get.width * 0.5,
                                                child: Obx(() {
                                                  return TextFormField(
                                                    controller: textController,
                                                    focusNode: _node,
                                                    cursorColor: Colors.white,
                                                    style: const TextStyle(
                                                      fontFamily: 'Mulish-Medium',
                                                      color: Colors.white,
                                                    ),
                                                    onTap: () {
                                                      _node.requestFocus();
                                                      playlistScrollController.isSearching = true;
                                                    },
                                                    decoration: InputDecoration(
                                                      hintText: 'Ara',
                                                      hintStyle: const TextStyle(
                                                        color: AppConstants.kHintText,
                                                        fontFamily: 'Mulish-SemiBold',
                                                      ),
                                                      filled: true,
                                                      fillColor: AppConstants.kAppGrey,
                                                      contentPadding: const EdgeInsets.all(1),
                                                      prefixIcon: Padding(
                                                        padding: EdgeInsets.all(Get.width * 0.04),
                                                        child: SvgPicture.asset(
                                                          'assets/icons/search.svg',
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      suffixIcon: playlistScrollController.isSearching
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                textController.clear();
                                                                _node.unfocus();
                                                                playlistScrollController.isSearching = false;
                                                              },
                                                              child: const Icon(
                                                                Icons.close_rounded,
                                                                color: Colors.white,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(8),
                                                        borderSide: const BorderSide(
                                                          width: 2,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.09,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  miniPlayerController.shuffledQueueList.shuffle();
                                                  miniPlayerController.shuffle = !miniPlayerController.shuffle;
                                                },
                                                child: Obx(() {
                                                  return SvgPicture.asset(
                                                    'assets/icons/shuffle.svg',
                                                    color: miniPlayerController.shuffle ? AppConstants.kPrimaryColor : AppConstants.kHintText,
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Obx(() {
                              return SizedBox(
                                height: Get.height * 0.15 * (snapshot.data!.datas[0].data[libraryController.tappedIndex].musics.length + 2),
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, listviewIndex) {
                                    int? myRate;
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.myrate == 0) {
                                        myRate = null;
                                      } else {
                                        myRate = snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.myrate;
                                      }
                                    }
                                    return Obx(
                                      () {
                                        return SongCard(
                                          showCrowns: false,
                                          title: snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.songName,
                                          videoId: snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.yMusicID,
                                          myRate: myRate?.toString(),
                                          ratePopup: RatePopup(
                                            title: snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.songName,
                                            alreadyRated: myRate == null ? false : true,
                                            myRate: myRate,
                                          ),
                                          totalRate: int.parse(snapshot
                                                      .data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.totalRate) >
                                                  10000
                                              ? '${(int.parse(snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.totalRate) / 1000).toStringAsFixed(1).trimRight()}K'
                                              : snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.totalRate,
                                          viewCount: snapshot
                                                      .data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.viewCount >
                                                  10000
                                              ? '${(snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.viewCount / 1000).toStringAsFixed(1)}K'
                                                  .trimRight()
                                              : snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.viewCount
                                                  .toString(),
                                          onTap: () {
                                            miniPlayerController.playingIndex = listviewIndex;
                                            miniPlayerController.queueList.clear();
                                            if (snapshot.hasData) {
                                              miniPlayerController.queueList.value = List.generate(
                                                snapshot.data!.datas[0].data[libraryController.tappedIndex].musics.length,
                                                (index) => [
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.id,
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.songName,
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.yMusicID,
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.thumbnail,
                                                ],
                                              );
                                              miniPlayerController.shuffledQueueList.value = List.generate(
                                                snapshot.data!.datas[0].data[libraryController.tappedIndex].musics.length,
                                                (index) => [
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.id,
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.songName,
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.yMusicID,
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.thumbnail,
                                                ],
                                              );
                                            }
                                            if (!miniPlayerController.isTapPlay) {
                                              miniPlayerController.isTapPlay = true;
                                              miniPlayerController.init(
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.yMusicID);
                                              miniPlayerController.videoID =
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.yMusicID;
                                            } else {
                                              miniPlayerController.youtubePlayerController.value.load(
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.yMusicID);
                                              miniPlayerController.videoID =
                                                  snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.yMusicID;
                                            }
                                            miniPlayerController.title =
                                                snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.songName;
                                            miniPlayerController.imgUrl =
                                                snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.thumbnail;
                                            print('playing index' + miniPlayerController.playingIndex.toString());
                                            print(miniPlayerController.queueList);
                                          },
                                          widget: playlistScrollController.tappedVideoIndex == listviewIndex
                                              ? YoutubeVideoPlayer(
                                                  videoId: snapshot
                                                      .data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.yMusicID)
                                              : GestureDetector(
                                                  onTap: () {
                                                    playlistScrollController.tappedVideoIndex = listviewIndex;
                                                  },
                                                  child: Container(
                                                    height: Get.height * 0.125,
                                                    width: Get.width * 0.32,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(snapshot.data!.datas[0].data[libraryController.tappedIndex]
                                                            .musics[listviewIndex].music.thumbnail),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          playButton:
                                              miniPlayerController.playingIndex == listviewIndex ? regularPlayButtons(miniPlayerController) : null,
                                          backGroundIndicator: miniPlayerController.playingIndex == listviewIndex
                                              ? Container(
                                                  margin: EdgeInsets.zero,
                                                  width: Get.width * 2,
                                                  height: Get.height * 0.15,
                                                  color: AppConstants.kAppGrey,
                                                )
                                              : null,
                                          imgUrl: snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[listviewIndex].music.thumbnail,
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
                                  itemCount: snapshot.data!.datas[0].data[0].musics.length,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Obx(() {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            color: playlistScrollController.showTopBar ? AppConstants.kAppGrey.withOpacity(1) : AppConstants.kAppGrey.withOpacity(0),
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.04,
                              vertical: Get.height * 0.04,
                            ),
                            child: SizedBox(
                              height: Get.height * 0.05,
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: Get.height * 0.02,
                                    child: GestureDetector(
                                      onTap: onTapBack,
                                      child: SvgPicture.asset('assets/icons/arrow-left.svg'),
                                    ),
                                  ),
                                  Positioned(
                                    top: Get.height * 0.02,
                                    child: AnimatedOpacity(
                                      duration: const Duration(milliseconds: 250),
                                      opacity: playlistScrollController.showTopBar ? 1 : 0,
                                      child: Text(
                                        "Türkçe pop listem",
                                        style: TextStyle(
                                          fontFamily: 'Mulish-Medium',
                                          color: Colors.white,
                                          fontSize: Get.width * 0.05,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: Get.height * 0.02,
                                    child: GestureDetector(
                                      onTap: playlistScrollController.showTopBar
                                          ? () {}
                                          : () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    alignment: Alignment.bottomCenter,
                                                    insetPadding: EdgeInsets.zero,
                                                    child: Container(
                                                      width: Get.width,
                                                      height: Get.height * 0.2,
                                                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.08, vertical: Get.width * 0.04),
                                                      color: AppConstants.kAppBlack,
                                                      child: Column(
                                                        children: [
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
                                                                              initialValue: snapshot
                                                                                  .data!.datas[0].data[libraryController.tappedIndex].listName,
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
                                                                                      'Kaydet',
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
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                  'assets/icons/edit.svg',
                                                                  color: AppConstants.kPrimaryColor,
                                                                  width: Get.width * 0.06,
                                                                ),
                                                                SizedBox(
                                                                  width: Get.width * 0.05,
                                                                ),
                                                                Text(
                                                                  'Çalma listesinin adını düzenle',
                                                                  style: TextStyle(
                                                                    fontFamily: 'Mulish-SemiBold',
                                                                    fontSize: Get.width * 0.04,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: Get.height * 0.03,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
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
                                                                          SvgPicture.asset(
                                                                            'assets/icons/trash.svg',
                                                                            color: Colors.redAccent,
                                                                          ),
                                                                          const SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(
                                                                            'Çalma Listesi Silindi.',
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
                                                              Get.back();
                                                              Get.back();
                                                            },
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                  'assets/icons/trash.svg',
                                                                  color: AppConstants.kPrimaryColor,
                                                                  width: Get.width * 0.06,
                                                                ),
                                                                SizedBox(
                                                                  width: Get.width * 0.05,
                                                                ),
                                                                Text(
                                                                  'Çalma listesini sil',
                                                                  style: TextStyle(
                                                                    fontFamily: 'Mulish-SemiBold',
                                                                    fontSize: Get.width * 0.04,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: Get.height * 0.03,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                              showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  return Dialog(
                                                                    alignment: Alignment.bottomCenter,
                                                                    insetPadding: EdgeInsets.zero,
                                                                    child: Container(
                                                                      height: Get.height * 0.45,
                                                                      width: Get.width,
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: Get.width * 0.08, vertical: Get.width * 0.04),
                                                                      color: AppConstants.kAppBlack,
                                                                      child: Column(
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                'assets/icons/instagram.svg',
                                                                                color: AppConstants.kPrimaryColor,
                                                                                width: Get.width * 0.08,
                                                                              ),
                                                                              SizedBox(
                                                                                width: Get.width * 0.05,
                                                                              ),
                                                                              Text(
                                                                                'İnstagram\'da paylaş',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Mulish-SemiBold',
                                                                                  fontSize: Get.width * 0.04,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: Get.height * 0.03,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                'assets/icons/whatsapp.svg',
                                                                                color: AppConstants.kPrimaryColor,
                                                                                width: Get.width * 0.08,
                                                                              ),
                                                                              SizedBox(
                                                                                width: Get.width * 0.05,
                                                                              ),
                                                                              Text(
                                                                                'Whatsapp\'da paylaş',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Mulish-SemiBold',
                                                                                  fontSize: Get.width * 0.04,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: Get.height * 0.03,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                'assets/icons/twitter.svg',
                                                                                color: AppConstants.kPrimaryColor,
                                                                                width: Get.width * 0.08,
                                                                              ),
                                                                              SizedBox(
                                                                                width: Get.width * 0.05,
                                                                              ),
                                                                              Text(
                                                                                'Twitter\'da paylaş',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Mulish-SemiBold',
                                                                                  fontSize: Get.width * 0.04,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: Get.height * 0.03,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                'assets/icons/sms.svg',
                                                                                color: AppConstants.kPrimaryColor,
                                                                                width: Get.width * 0.08,
                                                                              ),
                                                                              SizedBox(
                                                                                width: Get.width * 0.05,
                                                                              ),
                                                                              Text(
                                                                                'Sms ile paylaş',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Mulish-SemiBold',
                                                                                  fontSize: Get.width * 0.04,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: Get.height * 0.03,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                'assets/icons/sms.svg',
                                                                                color: AppConstants.kPrimaryColor,
                                                                                width: Get.width * 0.08,
                                                                              ),
                                                                              SizedBox(
                                                                                width: Get.width * 0.05,
                                                                              ),
                                                                              Text(
                                                                                'Eposta ile paylaş',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Mulish-SemiBold',
                                                                                  fontSize: Get.width * 0.04,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: Get.height * 0.03,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SvgPicture.asset(
                                                                                'assets/icons/link.svg',
                                                                                color: AppConstants.kPrimaryColor,
                                                                                width: Get.width * 0.08,
                                                                              ),
                                                                              SizedBox(
                                                                                width: Get.width * 0.05,
                                                                              ),
                                                                              Text(
                                                                                'Linki kopyala',
                                                                                style: TextStyle(
                                                                                  fontFamily: 'Mulish-SemiBold',
                                                                                  fontSize: Get.width * 0.04,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                  'assets/icons/share.svg',
                                                                  color: AppConstants.kPrimaryColor,
                                                                  width: Get.width * 0.06,
                                                                ),
                                                                SizedBox(
                                                                  width: Get.width * 0.05,
                                                                ),
                                                                Text(
                                                                  'Paylaş',
                                                                  style: TextStyle(
                                                                    fontFamily: 'Mulish-SemiBold',
                                                                    fontSize: Get.width * 0.04,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                      child: SvgPicture.asset(
                                        'assets/icons/more.svg',
                                        color: playlistScrollController.showTopBar ? Colors.white.withOpacity(0) : Colors.white.withOpacity(1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                      Obx(() {
                        return Positioned(
                          right: Get.width * 0.04,
                          top: Get.height * 0.09 + playlistScrollController.buttonPosition.clamp(0, double.infinity),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: Get.width * 0.15,
                                  height: Get.width * 0.15,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppConstants.kPrimaryColor,
                                  ),
                                  child: miniPlayerController.queueList.isNotEmpty
                                      ? regularPlayButtons(miniPlayerController)
                                      : SvgPicture.asset(
                                          'assets/icons/play.svg',
                                          color: Colors.white,
                                          width: Get.width * 0.05,
                                        ),
                                ),
                              ),
                              miniPlayerController.shuffle
                                  ? Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: Get.width * 0.05,
                                        height: Get.width * 0.05,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppConstants.kPrimaryColor,
                                          border: Border.all(
                                            color: AppConstants.kAppBlack,
                                          ),
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/icons/shuffle.svg',
                                            color: Colors.white,
                                            width: Get.width * 0.035,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  width: Get.width * 0.15,
                                  height: Get.width * 0.15,
                                  color: Colors.transparent,
                                ),
                                onTap: () {
                                  if (miniPlayerController.queueList.isEmpty) {
                                    if (snapshot.hasData) {
                                      miniPlayerController.queueList.value = List.generate(
                                        snapshot.data!.datas[0].data[libraryController.tappedIndex].musics.length,
                                        (index) => [
                                          snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.id,
                                          snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.songName,
                                          snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.yMusicID,
                                          snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.thumbnail,
                                        ],
                                      );
                                      miniPlayerController.shuffledQueueList.value = List.generate(
                                        snapshot.data!.datas[0].data[libraryController.tappedIndex].musics.length,
                                        (index) => [
                                          snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.id,
                                          snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.songName,
                                          snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.yMusicID,
                                          snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[index].music.thumbnail,
                                        ],
                                      );
                                      miniPlayerController.shuffledQueueList.shuffle();
                                    }
                                    if (!miniPlayerController.isTapPlay) {
                                      miniPlayerController.isTapPlay = true;
                                      miniPlayerController.init(
                                        miniPlayerController.shuffle
                                            ? miniPlayerController.shuffledQueueList[0][2]
                                            : snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[0].music.yMusicID,
                                      );
                                      miniPlayerController.videoID =
                                          snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[0].music.yMusicID;
                                    } else {
                                      miniPlayerController.youtubePlayerController.value.load(
                                        miniPlayerController.shuffle
                                            ? miniPlayerController.shuffledQueueList[0][2]
                                            : snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[0].music.yMusicID,
                                      );
                                      miniPlayerController.videoID = miniPlayerController.shuffle
                                          ? miniPlayerController.shuffledQueueList[0][2]
                                          : snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[0].music.yMusicID;
                                    }
                                    miniPlayerController.title = miniPlayerController.shuffle
                                        ? miniPlayerController.shuffledQueueList[0][1]
                                        : snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[0].music.songName;
                                    miniPlayerController.imgUrl = miniPlayerController.shuffle
                                        ? miniPlayerController.shuffledQueueList[0][3]
                                        : snapshot.data!.datas[0].data[libraryController.tappedIndex].musics[0].music.thumbnail;
                                  } else {
                                    if (miniPlayerController.playerState == PlayerState.playing) {
                                      miniPlayerController.youtubePlayerController.value.pause();
                                    } else if (miniPlayerController.playerState == PlayerState.paused) {
                                      miniPlayerController.youtubePlayerController.value.play();
                                    }
                                  }
                                  ;
                                },
                              ),
                            ],
                          ),
                        );
                      })
                    ],
                  )
                : CircularProgressIndicator();
          }),
    );
  }

  Widget regularPlayButtons(MiniPlayerController miniPlayerController, {bool? disableOnTap}) {
    switch (miniPlayerController.playerState) {
      case PlayerState.playing:
        return GestureDetector(
            onTap: disableOnTap == true
                ? () {}
                : () {
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
        return GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/play.svg',
              color: Colors.white,
              width: Get.width * 0.05,
            ));
    }
  }
}
