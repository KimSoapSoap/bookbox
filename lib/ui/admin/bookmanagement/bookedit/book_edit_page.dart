import 'dart:io';

import 'package:bookbox/ui/_components/default_layout.dart';
import 'package:bookbox/ui/main/library/_components/library_book.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

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
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      // 권한을 요청하고, 결과를 기다림
      status = await Permission.photos.request();
      print(status);
    }

    // 권한이 허용된 경우에만 이미지 선택 가능
    if (status.isGranted) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          print('선택된 이미지 경로: ${pickedFile.path}'); // 경로 출력
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
              onPressed: () async {
                // 앱 설정 화면으로 이동
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

  // 수정된 도서 정보를 저장하는 함수
  void _saveBook() {
    setState(() {
      widget.book.title = titleController.text;
      widget.book.author = authorController.text;
      widget.book.pubDate = pubDateController.text;
      widget.book.publisher = publisherController.text;

      // 이미 저장된 책 표지를 불러오도록 초기화
      //if (widget.book.cover.isNotEmpty) {
      //_imageFile = File(widget.book.cover); // 기존 표지 이미지가 있으면 설정
      //}
      // 실제 저장 로직 (API 요청 등) 추가
      //});

      //Navigator.pop(context); // 저장 후 페이지 종료
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '도서 수정',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveBook, // 저장 버튼
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    height: 200, // 도서 표지 크기 증가
                    width: 150,
                    fit: BoxFit.cover,
                  )
                else if (widget.book.cover!.isNotEmpty)
                  Image.network(
                    widget.book.cover ?? "",
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
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _pickImage();
                      }, // 도서 표지 선택
                      icon: Icon(Icons.photo_library),
                      label: Text('도서 표지 선택'),
                    ),
                    SizedBox(width: 16), // 버튼 간 간격 추가
                  ],
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

/* 선택한 이미지 저장 로직
  Future<void> _saveImage() async {
    if (_imageFile != null) {
      // 이미 선택한 이미지 파일이 있을 경우 저장 로직 처리
      try {
        // 저장할 파일의 경로 지정
        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        final fileName =
            'book_cover_${DateTime.now().millisecondsSinceEpoch}.png';
        final File newImage = await _imageFile!.copy('$path/$fileName');

        // 저장된 파일 경로를 출력하거나 다른 처리
        print('이미지가 저장되었습니다: ${newImage.path}');
        setState(() {
          widget.book.cover = newImage.path; // 책 표지 경로 업데이트
        });
      } catch (e) {
        print('이미지 저장 중 오류 발생: $e');
      }
    } else {
      print('저장할 이미지가 없습니다.');
    }
  }
  */
