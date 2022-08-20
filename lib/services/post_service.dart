import 'dart:convert';

import 'package:flutter_api/models/api_response.dart';
import 'package:flutter_api/models/post.dart';
import 'package:http/http.dart' as http;

class PostService {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";
  static const headers = <String, String>{'Content-Type': 'application/json'};

  Future<APIResponse<List<Post>?>> getAllposts() async {
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // Success
        var listOfPost = jsonDecode(response.body);
        List<Post> posts = [];
        for (var post in listOfPost) {
          posts.add(Post.fromJson(post));
        }
        return APIResponse(data: posts, error: false);
      } else {
        return APIResponse(error: true, errorMessage: "Something went wrong.");
      }
    } catch (e) {
      return APIResponse(error: true, errorMessage: "Something went wrong.");
    }
  }

  Future<APIResponse<Post>> getSinglePost({required int postId}) async {
    try {
      var response = await http.get(Uri.parse(apiUrl + "/$postId"));
      if (response.statusCode == 200) {
        // Success
        Post post = Post.fromJson(jsonDecode(response.body));
        return APIResponse(error: false, data: post);
      }
      // error
      return APIResponse(error: true, errorMessage: "Something went wrong.");
    } catch (e) {
      return APIResponse(error: true, errorMessage: "Something went wrong.");
    }
  }

  Future<APIResponse<bool>> addnewPost({required String title, required String body}) async {
    try {
      var response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: jsonEncode({title: title, body: body}));
      if (response.statusCode == 201) {
        return APIResponse(error: false, data: true);
      }
      return APIResponse(error: true, errorMessage: "Something went wrong.");
    } catch (e) {
      return APIResponse(error: true, errorMessage: "Something went wrong.");
    }
  }

  // what shoul i get as entry 

  Future<APIResponse<bool>> updatePost({required Post updatedPost}) async {
    try {
      var response = await http.put(Uri.parse(apiUrl+"/${updatedPost.id}"),
          headers: headers, body: jsonEncode(updatedPost.toJson()));
      if (response.statusCode == 200) {
        return APIResponse(error: false, data: true);
      }
      return APIResponse(error: true, errorMessage: "Something went wrong.");
    } catch (e) {
      return APIResponse(error: true, errorMessage: "Something went wrong.");
    }
  }

  deletePost({required int postId}) async {
    try {
      var response = await http.delete(Uri.parse(apiUrl+"/$postId"));
      if (response.statusCode == 200) {
        return APIResponse(error: false, data: true);
      }
      return APIResponse(error: true, errorMessage: "Something went wrong.");
    } catch (e) {
      return APIResponse(error: true, errorMessage: "Something went wrong.");
    }
  }
}
