import 'package:flutterframework/export.dart';

class LibraryController extends GetxController {
  RxBool _isGridTapped = false.obs;
  RxString _sortBy = 'En Yakın Tarihli'.obs;
  RxBool _isSearching = false.obs;

  get isGridTapped => _isGridTapped.value;
  set isGridTapped(value) => _isGridTapped.value = value;

  get sortBy => _sortBy.value;
  set sortBy(value) => _sortBy.value = value;

  get isSearching => _isSearching.value;
  set isSearching(value) => _isSearching.value = value;
}
