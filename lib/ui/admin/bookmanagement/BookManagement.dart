import 'package:bookbox/ui/admin/bookmanagement/_components/BookMagagement_body.dart';
import 'package:flutter/material.dart';

class Bookmanagement extends StatelessWidget {
  const Bookmanagement({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookManagementBody(),
      ],
    );
  }
}
