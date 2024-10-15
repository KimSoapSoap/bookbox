import 'dart:io';

import 'package:bookbox/ui/_components/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class BookAddPage extends StatefulWidget {
  const BookAddPage({Key? key}) : super(key: key);

  @override
  State<BookAddPage> createState() => _BookAddPageState();
}

class _BookAddPageState extends State<BookAddPage> {
  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController pubDateController;
  late TextEditingController publisherController;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    authorController = TextEditingController();
    pubDateController = TextEditingController();
    publisherController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    pubDateController.dispose();
    publisherController.dispose();
    super.dispose();
  }

  // 이미지 선택 함수 + 권한 요청 처리
  Future<void> _pickImage() async {
    var status = await Permission.photos.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } else {
      _showPermissionDeniedDialog();
    }
  }

  // 권한이 거부되었을 때 알림창
  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('권한 필요'),
          content: Text('갤러리 접근 권한이 필요합니다. 설정에서 권한을 허용해주세요.'),
          actions: [
            TextButton(
              onPressed: () async {
                await openAppSettings();
              },
              child: Text('설정 열기'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }

  // 새 도서 정보를 저장하는 함수
  void _saveBook() {
    // 새 도서 정보를 저장 (예: API 호출로 서버에 저장)
    print(
        '새 도서 정보 저장: ${titleController.text}, ${authorController.text}, ${pubDateController.text}, ${publisherController.text}');

    Navigator.pop(context); // 저장 후 페이지 종료
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '도서 등록',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveBook, // 저장 버튼
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: '책 제목',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: authorController,
              decoration: InputDecoration(
                labelText: '저자',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: pubDateController,
              decoration: InputDecoration(
                labelText: '출판일 ex) 2024-10-18',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: publisherController,
              decoration: InputDecoration(
                labelText: '출판사',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '도서 표지',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                if (_imageFile != null)
                  Image.file(
                    _imageFile!,
                    height: 200, // 도서 표지 크기 증가
                    width: 150,
                    fit: BoxFit.cover,
                  )
                else
                  Container(
                    height: 200, // 도서 표지 크기 증가
                    width: 150,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image,
                      size: 70, // 아이콘 크기 조정
                      color: Colors.grey[600],
                    ),
                  ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _pickImage, // 도서 표지 선택
                  icon: Icon(Icons.photo_library),
                  label: Text('도서 표지 선택'),
                ),
              ],
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveBook,
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
