import 'package:mfavymusic/export.dart';

class WeeklyTopController extends GetxController {
  final RxList _videoResult = [].obs;
  final RxBool _isAPIworking = false.obs;
  final RxInt _tappedVideoIndex = (-1).obs;
  final RxInt _tappedSoundIndex = (-1).obs;
  final RxInt _tapCounter = 0.obs;
  final RxInt _dropDownValue = 1.obs;
  final Rx<ScrollController> _scrollController = ScrollController().obs;

  get scrollController => _scrollController.value;
  set scrollController(value) => _scrollController.value = value;

  get dropDownValue => _dropDownValue.value;
  set dropDownValue(value) => _dropDownValue.value = value;

  get tapCounter => _tapCounter.value;
  set tapCounter(value) => _tapCounter.value = value;

  get tappedVideoIndex => _tappedVideoIndex.value;
  set tappedVideoIndex(value) => _tappedVideoIndex.value = value;

  get tappedSoundIndex => _tappedSoundIndex.value;
  set tappedSoundIndex(value) => _tappedSoundIndex.value = value;

  get videoResults => _videoResult.value;
  set videoResults(value) => _videoResult.value = value;

  get isAPIworking => _isAPIworking.value;
  set isAPIworking(value) => _isAPIworking.value = value;
}
