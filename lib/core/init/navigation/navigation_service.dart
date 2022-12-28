import '../../../bindings/library/library_binding.dart';
import '../../../export.dart';
import '../../../views/contact/contact_view.dart';
import '../../../views/library/library_view.dart';
import '../../../views/navigation/navigation_view.dart';
import '../../../views/onboard_view/onboard_view.dart';
import '../../../views/playlist/shared_playlist_view.dart';
import '../../../views/splash/splash_screen.dart';
import '../../../views/widgets/add_playlist_view.dart';

class NavigationService {
  static List<GetPage> routes = [
    GetPage(
      transitionDuration: const Duration(microseconds: 0),
      name: NavigationConstants.navigation,
      page: () => const NavigationView(),
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
      name: NavigationConstants.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: NavigationConstants.onboard,
      page: () => const OnboardView(),
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
      page: () => AddPlaylist(),
    ),
    GetPage(
      transition: Transition.cupertino,
      name: NavigationConstants.sharedPlaylist,
      page: () => SharedPlaylistView(),
    ),
  ];
}
