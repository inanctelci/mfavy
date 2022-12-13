import 'package:flutterframework/export.dart';

class HomeSearchController extends GetxController {
  final RxBool _isSearching = false.obs;
  final RxBool _isTypeing = false.obs;
  TextEditingController textController = TextEditingController();
  final RxBool _isAPIworking = false.obs;
  final RxList _videoResult = [].obs;
  final RxInt _tappedIndex = (-1).obs;

  get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;

  get isTypeing => _isTypeing.value;
  set isTypeing(value) => _isTypeing.value = value;

  get videoResults => _videoResult.value;
  set videoResults(value) => _videoResult.value = value;

  get isAPIworking => _isAPIworking.value;
  set isAPIworking(value) => _isAPIworking.value = value;

  get tappedIndex => _tappedIndex.value;
  set tappedIndex(value) => _tappedIndex.value = value;
}
