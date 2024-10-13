import 'package:flutter/material.dart';

class DetailPanel extends StatefulWidget {
  final bool isOpen; // 상태를 저장하는 리스트
  final Function togglePanel; // 특정 인덱스를 전달받는 함수
  final String title; // 패널 제목
  final String body; // 패널 내용

  DetailPanel({
    required this.isOpen,
    required this.togglePanel,
    required this.title,
    required this.body,
  });

  @override
  _DetailPanelState createState() => _DetailPanelState();
}

class _DetailPanelState extends State<DetailPanel> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
       widget.togglePanel();
      },
      children: [
        ExpansionPanel(
          backgroundColor: Colors.white,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(widget.title), // 동적으로 제목 사용
              );
            },
            body: ListTile(
              title: Text(widget.body), // 동적으로 내용 사용
            ),
            isExpanded: widget.isOpen,
        ),
      ],
    );
  }
}