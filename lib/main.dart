import 'package:flutter/services.dart';
import 'package:flutterframework/export.dart';
import 'package:just_audio_background/just_audio_background.dart';

void main() async {
  await JustAudioBackground.init(
    notificationColor: Color(0xFF422B73),
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.instance.preferencesInit();
  bool isDarkMode = LocaleManager.instance.getBool(PreferencesKeys.isDarkMode) ?? Get.isPlatformDarkMode;
  String languageCode =
      LocaleManager.instance.getString(PreferencesKeys.languageCode) ?? Get.deviceLocale?.languageCode ?? AppConstants.defaultLanguage;
  SystemUiOverlayStyle(
    statusBarColor: AppConstants.kAppBlack,
    systemNavigationBarColor: AppConstants.kAppBlack,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      getPages: NavigationService.routes,
      initialRoute: NavigationConstants.home,
      initialBinding: InitialBinding(), // Initial binding always run
      theme: AppTheme.instance.lightTheme,
      darkTheme: AppTheme.instance.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(languageCode),
      translations: Languages(),
    ),
  );
}
