import '../../export.dart';

class LibraryController extends GetxController {
  final RxBool _isGridTapped = false.obs;
  final RxString _sortBy = 'En Yeni Oluşturulan'.obs;
  final RxInt _sortOpt = 1.obs;
  final RxBool _isSearching = false.obs;
  final RxInt _tappedIndex = (9).obs;
  final RxString _tappedListName = ''.obs;
  final RxString _tappedListImg = ''.obs;
  // final RxBool updatePage = false.obs;
  PageController pageController = PageController(
    viewportFraction: 0.99,
  );

  get isGridTapped => _isGridTapped.value;
  set isGridTapped(value) => _isGridTapped.value = value;

  get sortOpt => _sortOpt.value;
  set sortOpt(value) => _sortOpt.value = value;

  get tappedListName => _tappedListName.value;
  set tappedListName(value) => _tappedListName.value = value;

  get tappedListImg => _tappedListImg.value;
  set tappedListImg(value) => _tappedListImg.value = value;

  get tappedIndex => _tappedIndex.value;
  set tappedIndex(value) => _tappedIndex.value = value;

  get sortBy => _sortBy.value;
  set sortBy(value) => _sortBy.value = value;

  get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;

  updatePage(id) {
    update([id]);
  }
}
