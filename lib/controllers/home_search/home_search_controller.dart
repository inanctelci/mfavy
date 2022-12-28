import '../../export.dart';

class HomeSearchController extends GetxController {
  final RxBool _isSearching = false.obs;
  final RxBool _isTypeing = false.obs;
  TextEditingController textController = TextEditingController();
  final RxBool _isAPIworking = false.obs;
  final RxList videoResult = [].obs;

  final RxInt _tappedVideoIndex = (-1).obs;
  final RxInt _tappedSoundIndex = (-1).obs;
  final Rx<ScrollController> _scrollController = ScrollController().obs;

  get scrollController => _scrollController.value;
  set scrollController(value) => _scrollController.value = value;

  get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;

  get isTypeing => _isTypeing.value;
  set isTypeing(value) => _isTypeing.value = value;

  get isAPIworking => _isAPIworking.value;
  set isAPIworking(value) => _isAPIworking.value = value;

  get tappedSoundIndex => _tappedSoundIndex.value;
  set tappedSoundIndex(value) => _tappedSoundIndex.value = value;

  get tappedVideoIndex => _tappedVideoIndex.value;
  set tappedVideoIndex(value) => _tappedVideoIndex.value = value;
}
