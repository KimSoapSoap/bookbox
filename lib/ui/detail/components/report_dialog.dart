// 다이얼로그를 호출하는 함수
import 'package:flutter/material.dart';

void showReportDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ReportDialog();
    },
  );
}

// ReportDialog 클래스 수정
class ReportDialog extends StatefulWidget {
  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String? _selectedReason;

  final List<String> _reasons = [
    '욕설',
    '스팸',
    '부적절한 콘텐츠',
    '혐오 발언',
    '위협',
    '기타',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('댓글 신고'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: _reasons.map((reason) {
          return RadioListTile<String>(
            title: Text(reason),
            value: reason,
            groupValue: _selectedReason,
            onChanged: (value) {
              setState(() {
                _selectedReason = value;
              });
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소'),
        ),
        TextButton(
          onPressed: () {
            if (_selectedReason != null) {
              print('신고 사유: $_selectedReason');
              // 신고 처리 로직 추가
            }
            Navigator.pop(context);
          },
          child: Text('신고'),
        ),
      ],
    );
  }
}
