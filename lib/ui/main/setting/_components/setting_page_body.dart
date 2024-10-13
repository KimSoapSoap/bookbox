import 'package:bookbox/core/constants/styles.dart';
import 'package:bookbox/ui/main/setting/_components/setting_log_out.dart';
import 'package:bookbox/ui/main/setting/_components/setting_row.dart';
import 'package:bookbox/ui/main/setting/_components/setting_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Push 알림 상태 관리
final pushNotificationProvider = StateProvider<bool>((ref) {
  return true; // 기본값
});

// 다크모드 상태 관리
final darkModeProvider = StateProvider<bool>((ref) {
  return false; // 기본값
});

class SettingPageBody extends ConsumerWidget {
  const SettingPageBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // StateProvider로부터 상태 읽기
    final isPushNotificationEnabled = ref.watch(pushNotificationProvider);

    // 현재 테마가 다크 모드인지 확인
    final themeMode = ref.watch(themeNotifierProvider);

    return ListView(
      children: [
        SettingSeparator(title: '내 계정'),
        SettingLogOut(
            username: '김그린',
            onLogout: () {
              // 로그아웃 로직
            }),
        SettingRow(
          title: '닉네임 변경',
          rightWidget: IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              print('닉네임 변경');
            },
          ),
        ),
        SettingRow(
          title: '비밀번호 변경',
          rightWidget: IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () {
              print('비번 변경');
            },
          ),
        ),
        SettingSeparator(title: '알림설정'),
        SettingRow(
          title: 'Push알림',
          rightWidget: Switch(
            value: isPushNotificationEnabled,
            onChanged: (val) {
              // 상태 업데이트
              ref.read(pushNotificationProvider.notifier).state = val;
              if (val) {
                print("Push알림 켜짐");
              } else {
                print("Push알림 꺼짐");
              }
            },
          ),
        ),
        SettingRow(
          title: '다크모드',
          rightWidget: Switch(
            value: themeMode == ThemeMode.dark, // 현재 테마 상태
            onChanged: (val) {
              // 다크 모드 상태 업데이트
              ref
                  .read(themeNotifierProvider.notifier)
                  .toggleTheme(val); // 테마 토글
              if (val) {
                print("다크모드 켜짐");
              } else {
                print("다크모드 꺼짐");
              }
            },
          ),
        ),
        SettingSeparator(title: '앱 정보'),
        SettingRow(
          title: '공지사항',
          rightWidget: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                print("공지사항");
              }),
        ),
        SettingRow(
          title: '고객 센터',
          rightWidget: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                print("고객 센터");
              }),
        ),
        SettingRow(
          title: '이용약관',
          rightWidget: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                print("이용약관");
              }),
        ),
        SettingRow(
          title: '개인정보처리방침',
          rightWidget: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                print("개인정보처리방침");
              }),
        ),
      ],
    );
  }
}
