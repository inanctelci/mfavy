import 'package:audio_session/audio_session.dart';
import 'package:flutterframework/export.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class MiniPlayerController extends GetxController {
  final RxString _title = ''.obs;
  final RxString _imgUrl = ''.obs;
  final RxBool _isTapPlay = false.obs;
  final RxBool _buttons = true.obs; // play and pause button, if true then its playing.
  final RxDouble _dragValue = 0.0.obs;
  final RxDouble _sliderValue = 0.0.obs;
  final RxString _positionText = '--:--'.obs;
  final Rx<AudioPlayer> player = AudioPlayer().obs;

  get title => _title.value;
  set title(value) => _title.value = value;

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

  Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    player.value.positionStream.listen((event) {
      sliderValue = player.value.position.inSeconds.toDouble();
      positionText = formatDuration(player.value.position);
    }, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
// "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3"
    try {
      await player.value.setAudioSource(
        AudioSource.uri(
          Uri.parse("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3"),
          tag: MediaItem(
            id: '1',
            title: "SoundHelix",
          ),
        ),
      );
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  String formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") + ":" + ((second < 10) ? "0$second" : "$second");
    return format;
  }

  @override
  void dispose() {
    player.value.dispose();
    super.dispose();
  }
}
