import 'package:flutterframework/bindings/playlist/playlist_binding.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/library/library_view.dart';
import 'package:flutterframework/views/widgets/add_playlist_view.dart';
import '../../../views/playlist/playlist_view.dart';

class NavigationService {
  static List<GetPage> routes = [
    GetPage(
      transitionDuration: const Duration(microseconds: 0),
      name: NavigationConstants.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: NavigationConstants.changeLanguage,
      page: () => ChangeLanguageView(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: NavigationConstants.connectionError,
      page: () => ConnectionErrorView(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: NavigationConstants.playlist,
      page: () => const PlaylistView(),
      binding: PlaylistBinding(),
    ),
    GetPage(
      transitionDuration: Duration(microseconds: 0),
      name: NavigationConstants.library,
      page: () => LibraryView(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: NavigationConstants.addPlaylist,
      page: () => AddPlaylist(),
    ),
  ];
}
