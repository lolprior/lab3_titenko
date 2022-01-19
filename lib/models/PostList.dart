import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:my_instagram/models/Post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedModelProvider with ChangeNotifier {
  final List<PostModel> _posts = [
    PostModel(
      id: 0,
      mainPhotoUrl: "assets/images/first (1).png",
      nickname: "Lets_go",
      userAvatar: "assets/images/first (2).png",
      description: "One two  One two One two One twoOne twoOne two",
      userPhoto: "assets/images/first (3).png",
    ),
    PostModel(
      id: 1,
      mainPhotoUrl: "assets/images/first (2).png",
      nickname: "123qweasd",
      userAvatar: "assets/images/first (3).png",
      description: "MonkMonkMonkMonkMonkMonkMonkMonkMonkMonkMonkMonkMonk",
      userPhoto: "assets/images/first (4).png",
    ),
    PostModel(
      id: 2,
      mainPhotoUrl: "assets/images/first (3).png",
      nickname: "qwe123",
      userAvatar: "assets/images/first (2).png",
      description: "Axaxxaaxxa axxa axxa axxa axxa axxa axxa vasdas",
      userPhoto: "assets/images/first (1).png",
    ),
  ];
  final List<PostModel> _favoritePosts = [];

  List<PostModel> getAllpPosts() {
    return _posts;
  }

  void add(PostModel post) {
    _posts.add(post);
    notifyListeners();
  }

  void addToArchive(PostModel post) {
    _favoritePosts.add(post);
    notifyListeners();
  }

  UnmodifiableListView<PostModel> get posts => UnmodifiableListView(_posts);

  PostModel getElementById(int id) =>
      _posts.singleWhere((value) => value.id == id);

  /// Removes all items from the cart.
}
