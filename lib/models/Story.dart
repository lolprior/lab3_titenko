import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:my_instagram/models/Post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryModel with ChangeNotifier {
  int id;
  String nickname;
  String userAvatar;
  bool active = true;

  StoryModel(int id, String nickname, String userAvatar, [bool active]) {
    this.id = id;
    this.nickname = nickname;
    this.userAvatar = userAvatar;
    this.active = active;
  }

  void changeState() {
    this.active = !(this.active);
  }
}
