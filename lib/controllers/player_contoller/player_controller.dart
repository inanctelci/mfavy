import 'package:flutterframework/export.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerController extends GetxController {
  late YoutubePlayerController youtubePlayerController;
  bool _isPlayerReady = false;
  RxBool _isTappedPlay = false.obs;

  get isTappedPlay => _isTappedPlay.value;
  set isTappedPlay(value) => _isTappedPlay.value = value;

  void listener() {
    if (_isPlayerReady && !youtubePlayerController.value.isFullScreen) {
      update();
    }
  }

  void init(String videoId) {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        hideControls: false,
        mute: false,
        autoPlay: true,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
        showLiveFullscreenButton: false,
      ),
    );
  }

  @override
  void onClose() {
    youtubePlayerController.pause();
    super.onClose();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }
}
