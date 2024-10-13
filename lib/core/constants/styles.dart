import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextTheme lightTextTheme() {
  return TextTheme(
    displayLarge: GoogleFonts.openSans(fontSize: 18.0, color: Colors.black),
    displayMedium: GoogleFonts.openSans(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.openSans(fontSize: 16.0, color: Colors.black),
    bodyMedium: GoogleFonts.openSans(fontSize: 14.0, color: Colors.grey),
    titleMedium: GoogleFonts.openSans(fontSize: 15.0, color: Colors.black),
  );
}

// 다크 모드 텍스트 테마
TextTheme darkTextTheme() {
  return TextTheme(
    displayLarge: GoogleFonts.openSans(fontSize: 18.0, color: Colors.white),
    displayMedium: GoogleFonts.openSans(
        fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold),
    bodyLarge: GoogleFonts.openSans(fontSize: 16.0, color: Colors.white),
    bodyMedium: GoogleFonts.openSans(fontSize: 14.0, color: Colors.white70),
    titleMedium: GoogleFonts.openSans(fontSize: 15.0, color: Colors.white),
  );
}

IconThemeData lightIconTheme() {
  return const IconThemeData(
    color: Colors.black,
  );
}

IconThemeData darkIconTheme() {
  return const IconThemeData(
    color: Colors.white,
  );
}

// 4
AppBarTheme lightAppBarTheme() {
  return AppBarTheme(
    centerTitle: false,
    color: Colors.white,
    elevation: 0.0,
    iconTheme: lightIconTheme(),
    titleTextStyle: GoogleFonts.nanumGothic(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}

AppBarTheme darkAppBarTheme() {
  return AppBarTheme(
    centerTitle: false,
    color: Colors.black,
    elevation: 0.0,
    iconTheme: darkIconTheme(),
    titleTextStyle: GoogleFonts.nanumGothic(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}

// 5
BottomNavigationBarThemeData lightBottomNavigatorTheme() {
  return const BottomNavigationBarThemeData(
    selectedItemColor: Colors.lightBlueAccent,
    unselectedItemColor: Colors.black54,
    showUnselectedLabels: true,
  );
}

BottomNavigationBarThemeData darkBottomNavigatorTheme() {
  return const BottomNavigationBarThemeData(
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.white70,
    backgroundColor: Colors.black,
    showUnselectedLabels: true,
  );
}

ThemeData lightTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: lightTextTheme(),
    appBarTheme: lightAppBarTheme(),
    bottomNavigationBarTheme: lightBottomNavigatorTheme(),
    primarySwatch: Colors.lightBlue,
  );
}

// 다크 모드 테마
ThemeData darkTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: darkTextTheme(),
    appBarTheme: darkAppBarTheme(),
    bottomNavigationBarTheme: darkBottomNavigatorTheme(),
    primarySwatch: Colors.lightBlue,
  );
}

// 테마 모드를 관리하는 StateNotifier
class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const _themePrefKey = 'theme_mode';

  ThemeNotifier() : super(ThemeMode.light) {
    _loadTheme(); // 테마 로드
  }

  // 다크 모드를 토글하는 메서드
  void toggleTheme(bool isDarkMode) async {
    if (isDarkMode) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
    await _saveTheme(); // 테마 저장
  }

// 테마를 SharedPreferences에 저장하는 메서드
  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePrefKey, state == ThemeMode.dark);
  }

// 앱 시작 시 저장된 테마를 불러오는 메서드
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(_themePrefKey) ?? false; // 기본값은 라이트 모드
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}

// StateNotifierProvider를 사용하여 테마 상태 제공
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
