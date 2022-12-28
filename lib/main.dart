import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  PurchasesConfiguration _configuration = PurchasesConfiguration(AppConstants.googleAPIKey);
  await Purchases.configure(_configuration);
  MobileAds.instance.initialize();
  //MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: ['C3D84D01021BA5A30139DB2B9C2F7ED1']));
  await LocaleManager.instance.preferencesInit();
  bool isDarkMode = LocaleManager.instance.getBool(PreferencesKeys.isDarkMode) ?? Get.isPlatformDarkMode;
  String languageCode =
      LocaleManager.instance.getString(PreferencesKeys.languageCode) ?? Get.deviceLocale?.languageCode ?? AppConstants.defaultLanguage;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFF252525),
    statusBarColor: AppConstants.kAppBlack,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      getPages: NavigationService.routes,
      initialRoute: NavigationConstants.splash,
      initialBinding: InitialBinding(), // Initial binding always run
      theme: AppTheme.instance.lightTheme,
      darkTheme: AppTheme.instance.darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(languageCode),
      translations: Languages(),
    ),
  );
}
