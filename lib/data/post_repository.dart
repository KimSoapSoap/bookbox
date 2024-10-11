import 'package:bookbox/core/utils.dart';
import 'package:bookbox/data/post.dart';
import 'package:dio/dio.dart';

class PostRepository {
  //싱글톤 방식 사용
  static PostRepository instance = PostRepository._single();

  PostRepository._single();

  // 1. 게시글목록
  Future<List<Post>> findAll() async {
    Response response = await dio.get("/api/post");
    List<dynamic> list = response.data["body"];
    List<Post> posts = list.map((e) => Post.fromJson(e)).toList();
    return posts;
  }

  // 2. 게시글상세보기
  Future<Post> findById(int id) async {
    Response response = await dio.get("/api/post/$id");
    Post post = Post.fromJson(response.data["body"]);
    return post;
  }

  // 3. 게시글쓰기
  Future<void> write(String title, String content) async {
    try {
      Response response = await dio.post(
        "/api/post",
        data: {"title": title, "content": content},
      );
    } catch (error) {
      throw Exception(error);
    }
  }

  // 4. 게시글삭제
  Future<void> deleteById(int id) async {
    try {
      Response response = await dio.delete("/api/post/$id");
    } catch (error) {
      throw Exception(error);
    }
  }
}
