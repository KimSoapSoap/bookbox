<div align= "center">
    <img src="https://capsule-render.vercel.app/api?type=waving&height=150&color=gradient&text=BookBox%20Project&descAlign=60&fontAlign=50&descAlignY=0&animation=fadeIn&fontSize=50" />
    </div>

<div align="center">
<img src = "https://github.com/user-attachments/assets/4f13baf9-0642-414e-8c5e-57e745404fa3">
</div>

## BookBox frontend v1.0.0

> (생성형AI활용)Springboot 기반 웹개발과 Flutter 기반 앱개발 실무양성 심화과정 5기
>
> Final Project 2조
>
> 개발기간: 2024.10.04 ~ 2024.10.17

<br>

## Back-End 주소 (Flutter)

> Front-End GitHub 주소 : https://github.com/KimSoapSoap/bookbox-api
>
> (배포 후 배포 서버 추가하기)

<br>

## Front-End 개발팀 소개

| [김성훈](https://github.com/KimSoapSoap)                                                                                      | [윤혜지](https://github.com/hyeji111544)                                                                                      | 
|----------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| <img src = "https://github.com/user-attachments/assets/b77191d1-ca55-486e-88ad-7c999791e193" width="100px" height="100px"> | <img src = "https://github.com/user-attachments/assets/7cdac4a2-0b04-428b-8b1f-91925c655978" width="100px" height="100px"> |

| [윤주헌](https://github.com/chunsicks)                                                                                        | [신민재](https://github.com/shnmj)                                                                                            | [김호정](https://github.com/HJK0000)                                                                                          |
|----------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| <img src = "https://github.com/user-attachments/assets/0366a170-63e4-4a74-8520-57269851973e" width="100px" height="100px"> | <img src = "https://github.com/user-attachments/assets/af6b3ead-d649-4f28-99c8-4cdd2fde155d" width="100px" height="100px"> | <img src = "https://github.com/user-attachments/assets/b935b1a8-d8e0-48cc-b502-a3016e5c8463" width="100px" height="100px"> |

<br>

## 프로젝트 소개

그린컴퓨터아카데미 Springboot 기반 웹개발과 Flutter 기반 앱개발 실무양성 심화과정 5기 과정
Final Project 2조의 **도서 대여/예약 앱 **입니다.

이 프로젝트는 Flutter를 사용해 개발된 프론트엔드와 Spring Boot를 기반으로 한 백엔드 서버로 구성되어 있습니다.

사용자는 애플리케이션을 통해 도서 대여/반납/예약, 도서 목록 조회, 대여중인 도서 및 예약중인 도서 관리, 즐겨찾기 추가 등을 할 수 있으며, 백엔드는 RESTful API를
통해 클라이언트와 통신합니다.

## 시작 가이드

### 설치 및 실행

```
git clone https://github.com/KimSoapSoap/bookbox.git
```

## 기술 스택

### Development

<img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=OpenJDK&logoColor=white">
<img src="https://img.shields.io/badge/Spring Boot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white">
<img src="https://img.shields.io/badge/Hibernate-59666C?style=for-the-badge&logo=Hibernate&logoColor=white">
<img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white">

### Communication

<img src="https://img.shields.io/badge/Notion-000000?style=for-the-badge&logo=notion&logoColor=white">
<img src="https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white">


<!-- <img src="https://img.shields.io/badge/표시할이름-색상?style=for-the-badge&logo=기술스택아이콘&logoColor=white"> -->

<br>

## API 주소 목록

🎁 API 문서 : https://getinthere.notion.site/API-1188a08b6c0d809db6a7ebcf421f63fc?pvs=4

<br>

## 주요 기능

⭐ **회원**

* 회원 가입, 로그인, JWT 토큰을 통한 인증 처리
  <br>
  <img src = "https://github.com/user-attachments/assets/3bbac067-cc40-4fec-87dc-a011a5baaa42" width="200px" height="400px">

<hr>

⭐ **도서**

* 도서 대여/반납/예약, 자동 반납 처리
  <br><br>
  <img src = "https://github.com/user-attachments/assets/25b8b9a6-3ed9-4be7-98a5-1ee25096a5ff" width="200px" height="400px">

<hr>

⭐ **도서목록**

* 카테고리/주제별 도서 목록
  <br><br>
  <img src = "https://github.com/user-attachments/assets/c5db034f-a6f9-4deb-ae84-d371b63c2e72" width="200px" height="400px">

<hr>

⭐ **즐겨찾기/리뷰**

* 도서 즐겨찾기 추가, 조회, 삭제 처리 / 리뷰 작성, 삭제
  <br><br>
  <img src = "https://github.com/user-attachments/assets/c73629ee-6ed1-4696-950a-76e0d8327971" width="200px" height="400px">

<hr>

⭐ **다크모드**

* 다크모드 적용
  <br><br>
  <img src = "https://github.com/user-attachments/assets/bfa742d7-494e-411e-82e0-ec80d66d203f" width="200px" height="400px">

<hr>

<br>

## 프로젝트 디렉토리 구조

```
📦lib
 ┣ 📂core
 ┃ ┣ 📂constants
 ┃ ┃ ┣ 📜color.dart
 ┃ ┃ ┣ 📜size.dart
 ┃ ┃ ┗ 📜styles.dart
 ┃ ┗ 📂utils
 ┃ ┃ ┣ 📜date_format.dart
 ┃ ┃ ┣ 📜exception_handler.dart
 ┃ ┃ ┣ 📜my_http.dart
 ┃ ┃ ┗ 📜validator_util.dart
 ┣ 📂data
 ┃ ┣ 📂gm
 ┃ ┃ ┗ 📜session_gm.dart
 ┃ ┗ 📂repository
 ┃ ┃ ┣ 📂admin
 ┃ ┃ ┣ 📂main
 ┃ ┃ ┃ ┣ 📂home
 ┃ ┃ ┃ ┣ 📂library
 ┃ ┃ ┃ ┃ ┣ 📜favorite_repository.dart
 ┃ ┃ ┃ ┃ ┣ 📜history_repository.dart
 ┃ ┃ ┃ ┃ ┣ 📜lend_repository.dart
 ┃ ┃ ┃ ┃ ┗ 📜reservation_repository.dart
 ┃ ┃ ┃ ┣ 📂search
 ┃ ┃ ┃ ┃ ┗ 📜serach_repository.drt.dart
 ┃ ┃ ┃ ┗ 📂setting
 ┃ ┃ ┗ 📂user
 ┃ ┃ ┃ ┗ 📜user_repository.dart
 ┣ 📂ui
 ┃ ┣ 📂admin
 ┃ ┃ ┣ 📂bookmanagement
 ┃ ┃ ┃ ┣ 📂bookadd
 ┃ ┃ ┃ ┣ 📂bookedit
 ┃ ┃ ┃ ┃ ┗ 📜book_edit_page.dart
 ┃ ┃ ┃ ┣ 📂bookregister
 ┃ ┃ ┃ ┃ ┗ 📜book_add_page.dart
 ┃ ┃ ┃ ┣ 📂_components
 ┃ ┃ ┃ ┃ ┗ 📜BookMagagement_body.dart
 ┃ ┃ ┃ ┣ 📜BookManagement.dart
 ┃ ┃ ┃ ┗ 📜BookManagement_vm.dart
 ┃ ┃ ┣ 📂report
 ┃ ┃ ┃ ┗ 📜Report.dart
 ┃ ┃ ┣ 📂usermanagement
 ┃ ┃ ┃ ┗ 📜UserManagement.dart
 ┃ ┃ ┗ 📜admin_page.dart
 ┃ ┣ 📂detail
 ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┣ 📜detail_btn.dart
 ┃ ┃ ┃ ┣ 📜detail_header.dart
 ┃ ┃ ┃ ┣ 📜detail_info.dart
 ┃ ┃ ┃ ┣ 📜detail_panel.dart
 ┃ ┃ ┃ ┣ 📜detail_review.dart
 ┃ ┃ ┃ ┣ 📜detail_vm.dart
 ┃ ┃ ┃ ┣ 📜popular_books.dart
 ┃ ┃ ┃ ┣ 📜report_dialog.dart
 ┃ ┃ ┃ ┗ 📜review_vm.dart
 ┃ ┃ ┣ 📜detail_book_page.dart
 ┃ ┃ ┗ 📜detail_repository.dart
 ┃ ┣ 📂main
 ┃ ┃ ┣ 📂home
 ┃ ┃ ┃ ┣ 📂cate_tab
 ┃ ┃ ┃ ┃ ┣ 📜cate_tab.dart
 ┃ ┃ ┃ ┃ ┣ 📜cate_tab_panel.dart
 ┃ ┃ ┃ ┃ ┗ 📜cate_tab_vm.dart
 ┃ ┃ ┃ ┣ 📂hit_tab
 ┃ ┃ ┃ ┃ ┣ 📜hit_tab.dart
 ┃ ┃ ┃ ┃ ┗ 📜hit_tab_vm.dart
 ┃ ┃ ┃ ┣ 📂recommend_tab
 ┃ ┃ ┃ ┃ ┣ 📜recommend_tab.dart
 ┃ ┃ ┃ ┃ ┗ 📜recommend_tab_vm.dart
 ┃ ┃ ┃ ┣ 📂uptodate_tab
 ┃ ┃ ┃ ┃ ┣ 📜uptodate_tab.dart
 ┃ ┃ ┃ ┃ ┗ 📜uptodate_tab_vm.dart
 ┃ ┃ ┃ ┣ 📂_components
 ┃ ┃ ┃ ┃ ┣ 📜home_Indicator.dart
 ┃ ┃ ┃ ┃ ┣ 📜home_list_item.dart
 ┃ ┃ ┃ ┃ ┣ 📜home_repository.dart
 ┃ ┃ ┃ ┃ ┗ 📜home_TopBtn.dart
 ┃ ┃ ┃ ┗ 📜home_page.dart
 ┃ ┃ ┣ 📂library
 ┃ ┃ ┃ ┣ 📂favorite_tab
 ┃ ┃ ┃ ┃ ┣ 📂_components
 ┃ ┃ ┃ ┃ ┃ ┗ 📜favorite_list_item.dart
 ┃ ┃ ┃ ┃ ┣ 📜favorite_tab.dart
 ┃ ┃ ┃ ┃ ┗ 📜favorite_tab_vm.dart
 ┃ ┃ ┃ ┣ 📂history_tab
 ┃ ┃ ┃ ┃ ┣ 📂_components
 ┃ ┃ ┃ ┃ ┃ ┗ 📜history_list_item.dart
 ┃ ┃ ┃ ┃ ┣ 📜history_tab.dart
 ┃ ┃ ┃ ┃ ┗ 📜history_tab_vm.dart
 ┃ ┃ ┃ ┣ 📂lend_tab
 ┃ ┃ ┃ ┃ ┣ 📂_components
 ┃ ┃ ┃ ┃ ┃ ┗ 📜lend_card_item.dart
 ┃ ┃ ┃ ┃ ┣ 📜lend_tab.dart
 ┃ ┃ ┃ ┃ ┗ 📜lend_tab_vm.dart
 ┃ ┃ ┃ ┣ 📂reserve_tab
 ┃ ┃ ┃ ┃ ┣ 📂_components
 ┃ ┃ ┃ ┃ ┃ ┗ 📜reserve_card_item.dart
 ┃ ┃ ┃ ┃ ┣ 📜reserve_tab.dart
 ┃ ┃ ┃ ┃ ┗ 📜reserve_tab_vm.dart
 ┃ ┃ ┃ ┣ 📂_components
 ┃ ┃ ┃ ┃ ┣ 📜library_book.dart
 ┃ ┃ ┃ ┃ ┣ 📜library_card_item.dart
 ┃ ┃ ┃ ┃ ┣ 📜library_lend.dart
 ┃ ┃ ┃ ┃ ┗ 📜library_list_item.dart
 ┃ ┃ ┃ ┣ 📜library_page.dart
 ┃ ┃ ┃ ┗ 📜library_page_vm.dart
 ┃ ┃ ┣ 📂search
 ┃ ┃ ┃ ┣ 📂_components
 ┃ ┃ ┃ ┃ ┣ 📜search_page_body.dart
 ┃ ┃ ┃ ┃ ┗ 📜search_page_list_item.dart
 ┃ ┃ ┃ ┣ 📜search_page.dart
 ┃ ┃ ┃ ┗ 📜search_page_vm.dart
 ┃ ┃ ┣ 📂setting
 ┃ ┃ ┃ ┣ 📂_components
 ┃ ┃ ┃ ┃ ┣ 📜setting_log_out.dart
 ┃ ┃ ┃ ┃ ┣ 📜setting_page_body.dart
 ┃ ┃ ┃ ┃ ┣ 📜setting_row.dart
 ┃ ┃ ┃ ┃ ┗ 📜setting_separator.dart
 ┃ ┃ ┃ ┣ 📜setting_page.dart
 ┃ ┃ ┃ ┗ 📜setting_page_vm.dart
 ┃ ┃ ┗ 📜main_page.dart
 ┃ ┣ 📂user
 ┃ ┃ ┣ 📂components
 ┃ ┃ ┃ ┗ 📜msg.dart
 ┃ ┃ ┣ 📂join
 ┃ ┃ ┃ ┣ 📜join_page.dart
 ┃ ┃ ┃ ┗ 📜join_page_vm.dart
 ┃ ┃ ┗ 📂login
 ┃ ┃ ┃ ┣ 📜login_page.dart
 ┃ ┃ ┃ ┗ 📜login_page_vm.dart
 ┃ ┗ 📂_components
 ┃ ┃ ┣ 📜book_base.dart
 ┃ ┃ ┣ 📜custom_action_btn.dart
 ┃ ┃ ┣ 📜custom_app_bar.dart
 ┃ ┃ ┣ 📜custom_card_item.dart
 ┃ ┃ ┣ 📜custom_dialog.dart
 ┃ ┃ ┣ 📜custom_floating_btn.dart
 ┃ ┃ ┣ 📜custom_form.dart
 ┃ ┃ ┣ 📜custom_list_item.dart
 ┃ ┃ ┣ 📜custom_text_form_field.dart
 ┃ ┃ ┣ 📜default_layout.dart
 ┃ ┃ ┗ 📜splash_screen.dart
 ┗ 📜main.dart
```

<br>

## 기타 추가 사항들

💻 팀블로그 : https://getinthere.notion.site/3e91f473e1184ad7be242f3f6edc7fe5?pvs=4

<br>

## 기여 방법

Pull request는 언제든지 환영합니다. 이슈를 생성해 버그를 신고하거나 새로운 기능을 제안해 주세요! 😊

<img src="https://capsule-render.vercel.app/api?type=rect&color=0:E34C26,10:DA5B0B,30:C6538C,75:3572A5,100:A371F7&height=40&section=footer&text=&fontSize=0" width="100%"/>
