import 'package:my_instagram/models/comment_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostModel with ChangeNotifier {
  final int id;
  final String nickname;
  final String userAvatar;
  final String mainPhotoUrl;
  final String description;
  final String userPhoto;
  bool like = false;
  int likesCount = 0;
  bool archive = false;

  List<Comment> comments = [];

  PostModel(
      {this.id,
      this.mainPhotoUrl,
      this.nickname,
      this.userAvatar,
      this.description,
      this.userPhoto});

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      id: map["id"],
      mainPhotoUrl: map["mainPhotoUrl"],
      nickname: map["nickname"],
      userAvatar: map["userAvater"],
      description: map["description"],
      userPhoto: map["userPhoto"],
    );
  }

  void changeLikeStatus() {
    this.like = !(this.like);
    if (this.like)
      incrementLikes();
    else
      decrementLikes();
    notifyListeners();
  }

  void incrementLikes() async {
    likesCount++;
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setInt(this.id.toString() + 'count', likesCount);
  }

  void decrementLikes() async {
    likesCount--;
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setInt(this.id.toString() + 'count', likesCount);
  }

  void changeArchiveStatus() {
    this.archive = !(this.archive);
    notifyListeners();
  }

  void addComment(Comment comment) {
    comments.add(comment);
    notifyListeners();
  }
}
