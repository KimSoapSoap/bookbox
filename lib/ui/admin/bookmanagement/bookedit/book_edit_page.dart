import 'dart:io';

import 'package:bookbox/ui/admin/bookmanagement/BookManagement_vm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart'; // 권한 처리 패키지

class BookEditPage extends StatefulWidget {
  final Book book;

  const BookEditPage({Key? key, required this.book}) : super(key: key);

  @override
  State<BookEditPage> createState() => _BookEditPageState();
}

class _BookEditPageState extends State<BookEditPage> {
  late TextEditingController titleController;
  late TextEditingController authorController;
  late TextEditingController pubDateController;
  late TextEditingController publisherController;

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.book.title);
    authorController = TextEditingController(text: widget.book.author);
    pubDateController = TextEditingController(text: widget.book.pubDate);
    publisherController = TextEditingController(text: widget.book.publisher);
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
    // 갤러리 접근 권한 요청
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      // 권한을 요청하고, 결과를 기다림
      status = await Permission.photos.request();
    }

    // 권한이 허용된 경우에만 이미지 선택 가능
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path); // 선택된 이미지 파일을 상태에 저장
        });
      }
    } else {
      // 권한이 거부된 경우 처리
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // 수정된 도서 정보를 저장하는 함수
  void _saveBook() {
    setState(() {
      widget.book.title = titleController.text;
      widget.book.author = authorController.text;
      widget.book.pubDate = pubDateController.text;
      widget.book.publisher = publisherController.text;

      if (_imageFile != null) {
        widget.book.cover = _imageFile!.path; // 선택된 이미지 경로를 도서 표지로 설정
      }

      // 실제 저장 로직 (API 요청 등) 추가
    });

    Navigator.pop(context); // 저장 후 페이지 종료
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('도서 수정'),
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
                labelText: '출판일',
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
                    height: 150,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                else if (widget.book.cover.isNotEmpty)
                  Image.network(
                    widget.book.cover,
                    height: 150,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                else
                  Container(
                    height: 150,
                    width: 100,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image,
                      size: 50,
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
