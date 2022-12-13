import 'package:flutterframework/export.dart';

class DailyTopController extends GetxController {
  final RxList _videoResult = [].obs;
  final RxBool _isAPIworking = false.obs;
  final RxInt _tappedVideoIndex = (-1).obs;
  final RxInt _tappedSoundIndex = (-1).obs;

  get tappedVideoIndex => _tappedVideoIndex.value;
  set tappedVideoIndex(value) => _tappedVideoIndex.value = value;

  get tappedSoundIndex => _tappedSoundIndex.value;
  set tappedSoundIndex(value) => _tappedSoundIndex.value = value;

  get videoResults => _videoResult.value;
  set videoResults(value) => _videoResult.value = value;

  get isAPIworking => _isAPIworking.value;
  set isAPIworking(value) => _isAPIworking.value = value;
}
