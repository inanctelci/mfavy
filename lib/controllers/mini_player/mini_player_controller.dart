import 'package:flutterframework/export.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MiniPlayerController extends GetxController {
  final RxString _videoID = ''.obs;
  final RxString _title = ''.obs;
  final RxString _imgUrl = ''.obs;
  final RxString _nextSongID = ''.obs;
  final RxString _nextSongYoutubeID = ''.obs;
  final RxString _nextSongTitle = ''.obs;
  final RxString _nextSongImgUrl = ''.obs;
  final RxBool _isTapPlay = false.obs;
  final RxBool _isReady = false.obs;
  final RxBool _buttons = true.obs; // true = playing, false = not playing,
  final RxBool _isEnded = false.obs;
  final Rx<PlayerState> _playerState = PlayerState.unknown.obs;
  final RxBool _shuffle = false.obs;
  final RxDouble _dragValue = 0.0.obs;
  final RxDouble _sliderValue = 0.0.obs;
  final RxDouble _duration = 0.0.obs;
  final RxString _positionText = '--:--'.obs;
  late Rx<YoutubePlayerController> youtubePlayerController;
  final RxInt _playingIndex = 0.obs;
  final Rx<UniqueKey> dismissKey = UniqueKey().obs;
  RxList queueList = [].obs;
  RxList shuffledQueueList = [].obs;

  get videoID => _videoID.value;
  set videoID(value) => _videoID.value = value;

  get playingIndex => _playingIndex.value;
  set playingIndex(value) => _playingIndex.value = value;

  get playerState => _playerState.value;
  set playerState(value) => _playerState.value = value;

  get isEnded => _isEnded.value;
  set isEnded(value) => _isEnded.value = value;

  get duration => _duration.value;
  set duration(value) => _duration.value = value;

  get shuffle => _shuffle.value;
  set shuffle(value) => _shuffle.value = value;

  get nextSongID => _nextSongID.value;
  set nextSongID(value) => _nextSongID.value = value;

  get nextSongTitle => _nextSongTitle.value;
  set nextSongTitle(value) => _nextSongTitle.value = value;

  get nextSongImgUrl => _nextSongImgUrl.value;
  set nextSongImgUrl(value) => _nextSongImgUrl.value = value;

  get nextSongYoutubeID => _nextSongYoutubeID.value;
  set nextSongYoutubeID(value) => _nextSongYoutubeID.value = value;

  get title => _title.value;
  set title(value) => _title.value = value;

  get isReady => _isReady.value;
  set isReady(value) => _isReady.value = value;

  get imgUrl => _imgUrl.value;
  set imgUrl(value) => _imgUrl.value = value;

  get isTapPlay => _isTapPlay.value;
  set isTapPlay(value) => _isTapPlay.value = value;

  get buttons => _buttons.value;
  set buttons(value) => _buttons.value = value;

  get dragValue => _dragValue.value;
  set dragValue(value) => _dragValue.value = value;

  get sliderValue => _sliderValue.value;
  set sliderValue(value) => _sliderValue.value = value;

  get positionText => _positionText.value;
  set positionText(value) => _positionText.value = value;

  void init(String videoId) {
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        enableCaption: false,
        autoPlay: true,
        disableDragSeek: true,
        showLiveFullscreenButton: false,
        useHybridComposition: false,
      ),
    ).obs;
    youtubePlayerController.value.addListener(() {
      sliderValue = youtubePlayerController.value.value.position.inSeconds.toDouble();
      playerState = youtubePlayerController.value.value.playerState;
      // isReady = youtubePlayerController.value.value.isReady;
      // youtubePlayerController.value.value.playerState == PlayerState.ended ? true : false;
      // youtubePlayerController.value.value.isPlaying ? buttons = true : buttons = false;
      duration = youtubePlayerController.value.metadata.duration.inSeconds.toDouble();
      // print(sliderValue);
      // positionText = formatDuration(youtubePlayerController.value.value.position);
    });
  }

  String formatDuration(Duration d) {
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = "${(minute < 10) ? "0$minute" : "$minute"}:${(second < 10) ? "0$second" : "$second"}";
    return format;
  }

  playNextSong() {
    playingIndex = (playingIndex + 1) % queueList.length;
  }

  playPrewSong() {
    playingIndex = (playingIndex - 1) % queueList.length;
  }
}
