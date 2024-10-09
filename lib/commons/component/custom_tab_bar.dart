import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final TabController? tabController;
  final List<Widget> items;

  const CustomTabBar(
      {required this.items, Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(controller: tabController, tabs: [...items]);
  }
}
