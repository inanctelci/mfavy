import 'package:flutterframework/export.dart';
class AppTheme {
  static final AppTheme _instance = AppTheme._init();
  static AppTheme get instance => _instance;

  AppTheme._init();

  ThemeData get lightTheme => ThemeData(
        colorScheme: const ColorScheme.light(),
        fontFamily: AppConstants.fontFamily,
        scaffoldBackgroundColor: Colors.white,
      );

  ThemeData get darkTheme => ThemeData(
        colorScheme: const ColorScheme.dark(),
        fontFamily: AppConstants.fontFamily,
        scaffoldBackgroundColor: Colors.black,
      );
}
