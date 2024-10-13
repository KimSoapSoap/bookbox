import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
  ThemeNotifier() : super(ThemeMode.light); // 기본 상태는 light 모드

  // 다크 모드를 토글하는 메서드
  void toggleTheme(bool isDarkMode) {
    if (isDarkMode) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}

// StateNotifierProvider를 사용하여 테마 상태 제공
final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
