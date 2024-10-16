import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPageNotifier extends StateNotifier<LoginPageState> {
  LoginPageNotifier() : super(LoginPageState());

  void dispose() {
    state.idFocusNode.dispose();
    state.passwordFocusNode.dispose();
    state.userIdController.dispose();
    state.passwordController.dispose();
  }
}

class LoginPageState {
  final FocusNode idFocusNode;
  final FocusNode passwordFocusNode;
  final TextEditingController userIdController;
  final TextEditingController passwordController;
  final ScrollController scrollController; // ScrollController 추가

  LoginPageState({
    FocusNode? idFocusNode,
    FocusNode? passwordFocusNode,
    TextEditingController? userIdController,
    TextEditingController? passwordController,
    ScrollController? scrollController, // ScrollController 초기화
  })  : idFocusNode = idFocusNode ?? FocusNode(),
        passwordFocusNode = passwordFocusNode ?? FocusNode(),
        userIdController = userIdController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController(),
        scrollController =
            scrollController ?? ScrollController(); // ScrollController 초기화
}

final loginPageProvider =
    StateNotifierProvider<LoginPageNotifier, LoginPageState>(
  (ref) => LoginPageNotifier(),
);
