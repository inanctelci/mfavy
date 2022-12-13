import 'package:flutterframework/export.dart';

class LibraryController extends GetxController {
  final RxBool _isGridTapped = false.obs;
  final RxString _sortBy = 'En Yeni Oluşturulan'.obs;
  final RxBool _isSearching = false.obs;
  final RxInt _tappedIndex = (0).obs;
  PageController pageController = PageController(
    viewportFraction: 0.99,
  );

  get isGridTapped => _isGridTapped.value;
  set isGridTapped(value) => _isGridTapped.value = value;

  get tappedIndex => _tappedIndex.value;
  set tappedIndex(value) => _tappedIndex.value = value;

  get sortBy => _sortBy.value;
  set sortBy(value) => _sortBy.value = value;

  get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;
}
