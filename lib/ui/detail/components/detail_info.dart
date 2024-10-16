import 'dart:math';

import 'package:bookbox/core/constants/color.dart';
import 'package:bookbox/core/constants/size.dart';
import 'package:bookbox/ui/admin/bookmanagement/BookManagement_vm.dart';
import 'package:bookbox/ui/detail/components/detail_review.dart';
import 'package:bookbox/ui/detail/components/detail_vm.dart';
import 'package:flutter/material.dart';

class DetailInfo extends StatelessWidget {
  final DetailBookInfo book;

  DetailInfo({required this.book});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final randomNumber = random.nextInt(10000) + 1;
    return Container(
      padding: EdgeInsets.all(gap_m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                '$randomNumber명이 읽고 있어요',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          SizedBox(height: gap_s),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('파일형식: EPUB'),
                      Text('글자수: 약 40.6만 자'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('듣기가능: TTS 지원'),
                      Text('용량: 11.89MB'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: gap_m),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: SECONDARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailReview(book: book),
                      ),
                    );
                  },
                  child: Text(
                    '리뷰 보기',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: gap_m),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '책 소개',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 8),
              Text(
                '핵 플렉스 원리 기반, 상징적인 모험과의 충돌. 한 편에 네 번의 복수가 담기는 곳!',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
