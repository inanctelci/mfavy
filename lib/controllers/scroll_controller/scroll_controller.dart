import '../../export.dart';

class PlaylistScrollController extends GetxController {
  final _imageSize = (Get.height * 0.25).obs;
  final _initialSize = (Get.height * 0.25).obs;
  final _buttonPosition = (Get.height * 0.31).obs;
  final _containerinitalHeight = (Get.height * 0.31).obs;
  final _imageOpacity = 1.0.obs;
  final _showTopBar = false.obs;
  final _isSearching = false.obs;
  final _textController = TextEditingController().obs;
  final _tappedSongIndex = (-1).obs;
  final _tappedVideoIndex = (-1).obs;

  ScrollController controller = ScrollController();

  get imageSize => _imageSize.value;
  set imageSize(value) => _imageSize.value = value;

  get tappedSongIndex => _tappedSongIndex.value;
  set tappedSongIndex(value) => _tappedSongIndex.value = value;

  get tappedVideoIndex => _tappedVideoIndex.value;
  set tappedVideoIndex(value) => _tappedVideoIndex.value = value;

  get initialSize => _initialSize.value;
  set initialSize(value) => _initialSize.value = value;

  get buttonPosition => _buttonPosition.value;
  set buttonPosition(value) => _buttonPosition.value = value;

  get containerHeight => _containerinitalHeight.value;
  set containeHeight(value) => _containerinitalHeight.value = value;

  get imageOpacity => _imageOpacity.value;
  set imageOpacity(value) => _imageOpacity.value = value;

  get showTopBar => _showTopBar.value;
  set showTopBar(value) => _showTopBar.value = value;

  get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;

  get textController => _textController.value;
  set textController(value) => _textController.value = value;

  @override
  void onInit() {
    calcButtonPosition();
    super.onInit();
  }

  calcButtonPosition() async {
    controller.addListener(() {
      _imageSize.value = _initialSize.value - controller.offset;
      if (_imageSize < 0) {
        _imageSize.value = 0;
      }
      _buttonPosition.value = _containerinitalHeight.value - controller.offset;
      if (_buttonPosition < 0) {
        _buttonPosition.value = 0;
      }
      _imageOpacity.value = _imageSize.value / _initialSize.value;
      if (controller.offset > Get.height * 0.2) {
        _showTopBar.value = true;
      } else {
        _showTopBar.value = false;
      }
      update();
    });
  }
}
