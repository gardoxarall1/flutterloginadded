import 'package:flutter/cupertino.dart';
import 'package:new1/models/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PostsProivider extends ChangeNotifier {
  List<Post> list = [];
  bool isLoading = false;
  int likesNumber = 0;
  Future getList() async {
    isLoading = true;

    List<Post> listPosts = [];

    var url = Uri.parse(
        "https://api-app-a161b-default-rtdb.firebaseio.com/posts.json");

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      jsonResponse.forEach((key, value) {
        Post element = Post.fromJson(value);
        listPosts.add(element);
      });
      list = listPosts;

      isLoading = false;
    } else {
      isLoading = false;
    }
    notifyListeners();
  }

  onPressedLike(int index) {
    list[index].isLike = !list[index].isLike!;
    if (list[index].isLike!) {
      likesNumber++;
    } else {
      likesNumber--;
    }
    notifyListeners();
  }

  AddPost(Post post) {
    list.add(post);
    notifyListeners();
  }
}
