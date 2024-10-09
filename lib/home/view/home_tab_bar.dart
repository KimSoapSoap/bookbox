import 'package:flutter/material.dart';

class HomeTabBar extends StatelessWidget {
  final TabController? tabController;

  const HomeTabBar({Key? key, required this.tabController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        Container(color: Colors.deepOrangeAccent),
        Container(color: Colors.lightGreen),
        Column(
          children: [
            Row(
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.grey, width: 1),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: () {},
                  child: Text("인문", style: TextStyle(color: Colors.black)),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
