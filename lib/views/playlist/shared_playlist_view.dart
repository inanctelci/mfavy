import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../controllers/future/future_controller.dart';
import '../../controllers/mini_player/mini_player_controller.dart';
import '../../controllers/mini_player/other_mini_player_controller.dart';
import '../../controllers/scroll_controller/other_scroll_controller.dart';
import '../../export.dart';
import '../../models/music/music_listener_req_model.dart';
import '../../models/music_list/delete_music_from_list_req_model.dart';
import '../../models/share_list/share_list_model.dart';
import '../../services/list/list_music_service.dart';
import '../../services/music/music_service.dart';
import '../widgets/other_mini_player.dart';
import '../widgets/rate_popup.dart';
import '../widgets/song_card.dart';
import '../widgets/youtube_video_player.dart';

class SharedPlaylistView extends StatelessWidget {
  SharedPlaylistView({
    Key? key,
  }) : super(key: key);

  final FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext buildContext) {
    OtherScrollController playlistScrollController = Get.put<OtherScrollController>(OtherScrollController());
    var textController = playlistScrollController.textController as TextEditingController;
    OtherMiniPlayerController miniPlayerController = Get.put<OtherMiniPlayerController>(OtherMiniPlayerController());
    MiniPlayerController mpc = Get.find();
    if (mpc.isTapPlay) {
      mpc.youtubePlayerController.value.pause();
    }
    FutureContoller futureContoller = Get.find<FutureContoller>();
    var args = Get.arguments;

    return Scaffold(
      backgroundColor: AppConstants.kAppBlack,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 5,
          ),
          OtherMiniPlayer(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      body: GetBuilder<FutureContoller>(
          init: FutureContoller(),
          id: 'otherPlaylist',
          builder: (getcontext) {
            return FutureBuilder<ShareListModel>(
                future: ListMusicService().getSharedList(int.parse(args)),
                builder: (futureContext, snapshot) {
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
                                            child: snapshot.data!.data[0].listinfo!.thumbnail == "."
                                                ? Image.asset('assets/images/playlist.png')
                                                : Image.network(
                                                    snapshot.data!.data[0].listinfo!.thumbnail!,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return const SizedBox();
                                                    },
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
                                                Text(
                                                  snapshot.data!.data[0].listinfo!.listName!,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  style: TextStyle(
                                                    fontFamily: 'Mulish-Medium',
                                                    color: Colors.white,
                                                    fontSize: Get.width * 0.05,
                                                  ),
                                                ),
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
                                                          enabled: snapshot.data!.data[0].arra!.isNotEmpty ? false : true,
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
                                                            disabledBorder: OutlineInputBorder(
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                    SizedBox(
                                                      width: Get.width * 0.09,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {},
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
                                  SizedBox(
                                    height: Get.height *
                                        0.6 *
                                        (snapshot.data!.data[0].arra!.isEmpty
                                            ? 1
                                            : snapshot.data!.data[0].arra!.length), // (snapshot.data!.data[0].result.datas.length + 2),
                                    child: snapshot.data!.data[0].arra!.isEmpty
                                        ? Column(
                                            children: [
                                              SizedBox(
                                                height: Get.height * 0.05,
                                              ),
                                              Image.asset(
                                                'assets/images/empty_playlist.png',
                                                width: Get.width * 0.4,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.05,
                                              ),
                                              Text(
                                                "Listende hiç şarkı yok :(",
                                                style: TextStyle(
                                                  fontFamily: 'Mulish-Medium',
                                                  color: Colors.white,
                                                  fontSize: Get.width * 0.05,
                                                ),
                                              ),
                                            ],
                                          )
                                        : ListView.separated(
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemBuilder: (itemContext, listviewIndex) {
                                              int? myRate;
                                              if (snapshot.hasData) {
                                                if (snapshot.data!.data[0].arra![listviewIndex].music!.myrate == 0) {
                                                  myRate = null;
                                                } else {
                                                  myRate = snapshot.data!.data[0].arra![listviewIndex].music!.myrate;
                                                }
                                              }
                                              return Obx(
                                                () {
                                                  return SongCard(
                                                    showCrowns: false,
                                                    title: snapshot.data!.data[0].arra![listviewIndex].music!.songName!,
                                                    // title: playlistScrollController.videoResults[index].title,
                                                    viewCount: snapshot.data!.data[0].arra![listviewIndex].music!.viewCount!.toString(),
                                                    ratePopup: RatePopup(
                                                      title: snapshot.data!.data[0].arra![listviewIndex].music!.songName!,
                                                      youtubeID: snapshot.data!.data[0].arra![listviewIndex].music!.yMusicID!,
                                                      alreadyRated: myRate == null ? false : true,
                                                      myRate: myRate,
                                                      ids: [
                                                        'otherPlaylist',
                                                      ],
                                                    ),
                                                    totalRate: snapshot.data!.data[0].arra![listviewIndex].music!.totalRate!.toString(),
                                                    myRate: myRate?.toString(),
                                                    addPlaylistButton: () {
                                                      MusicService()
                                                          .musicListen(MusicListenerReqModel(
                                                              listID: 0,
                                                              id: snapshot.data!.data[0].arra![listviewIndex].music!.yMusicID!,
                                                              title: snapshot.data!.data[0].arra![listviewIndex].music!.songName!,
                                                              thumbnails: snapshot.data!.data[0].arra![listviewIndex].music!.thumbnail!))
                                                          .then((value) {
                                                        Get.toNamed(
                                                          NavigationConstants.addPlaylist,
                                                          arguments: {
                                                            "id": snapshot.data!.data[0].arra![listviewIndex].music!.yMusicID!,
                                                            "title": snapshot.data!.data[0].arra![listviewIndex].music!.songName!,
                                                            "thumbnail": snapshot.data!.data[0].arra![listviewIndex].music!.thumbnail!,
                                                          },
                                                        );
                                                      });
                                                    },
                                                    onTap: () {
                                                      playlistScrollController.tappedSongIndex = listviewIndex;
                                                      playlistScrollController.tappedVideoIndex = -1;
                                                      miniPlayerController.queueList.clear();
                                                      if (!miniPlayerController.isTapPlay) {
                                                        miniPlayerController.isTapPlay = true;
                                                        miniPlayerController.init(snapshot.data!.data[0].arra![listviewIndex].music!.yMusicID!);
                                                        miniPlayerController.videoID = snapshot.data!.data[0].arra![listviewIndex].music!.yMusicID!;
                                                      } else {
                                                        miniPlayerController.youtubePlayerController.value
                                                            .load(snapshot.data!.data[0].arra![listviewIndex].music!.yMusicID!);
                                                        miniPlayerController.videoID = snapshot.data!.data[0].arra![listviewIndex].music!.yMusicID!;
                                                      }
                                                      miniPlayerController.title = snapshot.data!.data[0].arra![listviewIndex].music!.songName!;
                                                      miniPlayerController.imgUrl = snapshot.data!.data[0].arra![listviewIndex].music!.thumbnail!;
                                                      MusicService().musicListen(
                                                        MusicListenerReqModel(
                                                          listID: 0,
                                                          id: miniPlayerController.videoID,
                                                          title: miniPlayerController.title,
                                                          thumbnails: miniPlayerController.imgUrl,
                                                        ),
                                                      );
                                                    },
                                                    widget: playlistScrollController.tappedVideoIndex == listviewIndex
                                                        ? YoutubeVideoPlayer(videoId: snapshot.data!.data[0].arra![listviewIndex].music!.yMusicID!)
                                                        : GestureDetector(
                                                            onTap: () {
                                                              playlistScrollController.tappedSongIndex = -1;
                                                              playlistScrollController.tappedVideoIndex = listviewIndex;
                                                              MusicService().musicListen(
                                                                MusicListenerReqModel(
                                                                  listID: 0,
                                                                  id: snapshot.data!.data[0].arra![listviewIndex].music!.yMusicID!,
                                                                  title: snapshot.data!.data[0].arra![listviewIndex].music!.songName!,
                                                                  thumbnails: snapshot.data!.data[0].arra![listviewIndex].music!.thumbnail!,
                                                                ),
                                                              );
                                                              playlistScrollController.tappedVideoIndex = listviewIndex;
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
                                                                        snapshot.data!.data[0].arra![listviewIndex].music!.thumbnail!,
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
                                                    playButton: playlistScrollController.tappedSongIndex == listviewIndex
                                                        ? regularPlayButtons(miniPlayerController)
                                                        : null,
                                                    backGroundIndicator: playlistScrollController.tappedSongIndex == listviewIndex ||
                                                            playlistScrollController.tappedVideoIndex == listviewIndex
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
                                            itemCount: snapshot.data!.data[0].arra!.length),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              child: Obx(() {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  color: playlistScrollController.showTopBar
                                      ? AppConstants.kAppGrey.withOpacity(1)
                                      : AppConstants.kAppGrey.withOpacity(0),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.04,
                                    vertical: Get.height * 0.04,
                                  ),
                                  child: SizedBox(
                                    height: Get.height * 0.05,
                                    width: MediaQuery.of(buildContext).size.width,
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: Get.height * 0.02,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.back();
                                              miniPlayerController.isTapPlay = false;
                                              miniPlayerController.dispose();
                                            },
                                            child: SvgPicture.asset('assets/icons/arrow-left.svg'),
                                          ),
                                        ),
                                        Positioned(
                                          top: Get.height * 0.02,
                                          child: AnimatedOpacity(
                                            duration: const Duration(milliseconds: 250),
                                            opacity: playlistScrollController.showTopBar ? 1 : 0,
                                            child: Text(
                                              snapshot.data!.data[0].listinfo!.listName!,
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
                                            onTap: () {},
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
                                child: snapshot.data!.data[0].arra!.isEmpty
                                    ? Container(
                                        width: Get.width * 0.15,
                                        height: Get.width * 0.15,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppConstants.kPrimaryColor.withOpacity(0.3),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/play.svg',
                                          color: Colors.white,
                                          width: Get.width * 0.05,
                                        ),
                                      )
                                    : Stack(
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
                                              child: miniPlayerController.playingPlaylistIndex == 2
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
                                              if (miniPlayerController.playingPlaylistIndex != 2) {
                                                miniPlayerController.queueList.clear();
                                              }
                                              miniPlayerController.playingPlaylistIndex = 2;
                                              if (miniPlayerController.queueList.isEmpty) {
                                                if (snapshot.hasData) {
                                                  miniPlayerController.queueList.value = List.generate(
                                                    snapshot.data!.data[0].arra!.length,
                                                    (index) => [
                                                      snapshot.data!.data[0].arra![index].music!.songName!,
                                                      snapshot.data!.data[0].arra![index].music!.yMusicID!,
                                                      snapshot.data!.data[0].arra![index].music!.thumbnail!,
                                                    ],
                                                  );
                                                  miniPlayerController.shuffledQueueList.value = List.generate(
                                                    snapshot.data!.data[0].arra!.length,
                                                    (index) => [
                                                      snapshot.data!.data[0].arra![index].music!.songName!,
                                                      snapshot.data!.data[0].arra![index].music!.yMusicID!,
                                                      snapshot.data!.data[0].arra![index].music!.thumbnail!,
                                                    ],
                                                  );
                                                  miniPlayerController.shuffledQueueList.shuffle();
                                                }
                                                if (!miniPlayerController.isTapPlay) {
                                                  miniPlayerController.isTapPlay = true;
                                                  miniPlayerController.init(
                                                    miniPlayerController.shuffle
                                                        ? miniPlayerController.shuffledQueueList[0][1]
                                                        : miniPlayerController.queueList[0][1],
                                                  );
                                                  miniPlayerController.videoID = miniPlayerController.shuffle
                                                      ? miniPlayerController.shuffledQueueList[0][1]
                                                      : miniPlayerController.queueList[0][1];
                                                  miniPlayerController.playingIndex = 0;
                                                } else {
                                                  miniPlayerController.youtubePlayerController.value.load(
                                                    miniPlayerController.shuffle
                                                        ? miniPlayerController.shuffledQueueList[0][1]
                                                        : miniPlayerController.queueList[0][1],
                                                  );
                                                  miniPlayerController.videoID = miniPlayerController.shuffle
                                                      ? miniPlayerController.shuffledQueueList[0][1]
                                                      : miniPlayerController.queueList[0][1];
                                                }
                                                miniPlayerController.title = miniPlayerController.shuffle
                                                    ? miniPlayerController.shuffledQueueList[0][0]
                                                    : miniPlayerController.queueList[0][0];
                                                miniPlayerController.imgUrl = miniPlayerController.shuffle
                                                    ? miniPlayerController.shuffledQueueList[0][2]
                                                    : miniPlayerController.queueList[0][2];
                                              } else {
                                                if (miniPlayerController.playerState == PlayerState.playing) {
                                                  miniPlayerController.youtubePlayerController.value.pause();
                                                } else if (miniPlayerController.playerState == PlayerState.paused) {
                                                  miniPlayerController.youtubePlayerController.value.play();
                                                }
                                              }
                                              MusicService().musicListen(
                                                MusicListenerReqModel(
                                                  listID: 0,
                                                  id: miniPlayerController.videoID,
                                                  title: miniPlayerController.title,
                                                  thumbnails: miniPlayerController.imgUrl,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                              );
                            })
                          ],
                        )
                      : const Center(child: CircularProgressIndicator());
                });
          }),
    );
  }

  dialogShower(BuildContext context, String songName, int listID, String ytId, FutureContoller controller) {
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
                  '$songName şarkısını listenizden çıkartmak istiyor musunuz?',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Mulish-ExtraBold',
                    color: Colors.white,
                    fontSize: Get.width * 0.035,
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
                          color: AppConstants.kPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Hayır',
                            style: TextStyle(
                              color: Colors.white,
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
                        ListMusicService().deleteMusicFromList(DeleteMusicReqModel(listID: listID, yMusicID: ytId)).then((value) {
                          if (value.success == 1) {
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
                                          'Müzik listeden başarıyla kaldırıldı.',
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
                                        SvgPicture.asset('assets/icons/message-question.svg'),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Bir şeyler ters gitti.',
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
                        });
                        Get.back();
                        controller.updatePage(['playlist']);
                      },
                      child: Container(
                        height: Get.height * 0.04,
                        width: Get.width * 0.3,
                        decoration: BoxDecoration(
                          color: AppConstants.kAppBlack,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Evet',
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
  }

  Widget regularPlayButtons(OtherMiniPlayerController miniPlayerController, {bool? disableOnTap}) {
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
