import 'package:flutterframework/bindings/library/library_binding.dart';
import 'package:flutterframework/bindings/playlist/playlist_binding.dart';
import 'package:flutterframework/export.dart';
import 'package:flutterframework/views/contact/contact_view.dart';
import 'package:flutterframework/views/library/library_view.dart';
import 'package:flutterframework/views/navigation/navigation_view.dart';
import 'package:flutterframework/views/onboard_view/onboard_view.dart';
import 'package:flutterframework/views/widgets/add_playlist_view.dart';
import '../../../views/playlist/playlist_view.dart';

class NavigationService {
  static List<GetPage> routes = [
    GetPage(
      transitionDuration: const Duration(microseconds: 0),
      name: NavigationConstants.navigation,
      page: () => NavigationView(),
      bindings: [
        HomeBinding(),
        LibraryBinding(),
      ],
    ),
    GetPage(
      name: NavigationConstants.changeLanguage,
      page: () => ChangeLanguageView(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: NavigationConstants.onboard,
      page: () => OnboardView(),
    ),
    GetPage(
      name: NavigationConstants.contact,
      page: () => ContactView(),
    ),
    GetPage(
      name: NavigationConstants.connectionError,
      page: () => ConnectionErrorView(),
    ),
    // GetPage(
    //   transition: Transition.cupertino,
    //   name: NavigationConstants.playlist,
    //   page: () => PlaylistView(),
    //   binding: PlaylistBinding(),
    // ),
    GetPage(
      transitionDuration: const Duration(microseconds: 0),
      name: NavigationConstants.library,
      page: () => LibraryView(),
      binding: LibraryBinding(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: NavigationConstants.addPlaylist,
      page: () => const AddPlaylist(),
    ),
  ];
}
