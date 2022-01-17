import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:my_instagram/models/Story.dart';
import 'package:flutter/material.dart';

class StoriesFeed with ChangeNotifier {
  final List<StoryModel> _stories = [
    StoryModel(
      0,
      'st.l1ght',
      "assets/images/first (2).png",
      false,
    ),
    StoryModel(
      1,
      '1weqwe',
      "assets/images/first (1).png",
      true,
    ),
    StoryModel(
      2,
      'sqwesxzc',
      "assets/images/first (3).png",
      true,
    ),
    StoryModel(
      3,
      'spdogkcxv',
      "assets/images/first (1).png",
      true,
    ),
    StoryModel(
      4,
      'dlckckdw',
      "assets/images/first (2).png",
      true,
    ),
    StoryModel(
      5,
      'sasd',
      "assets/images/first (3).png",
      true,
    ),
    StoryModel(
      6,
      'qdsa',
      "assets/images/first (4).png",
      true,
    ),
  ];
  UnmodifiableListView<StoryModel> get stories =>
      UnmodifiableListView(_stories);

  StoryModel getElementById(int id) =>
      _stories.singleWhere((value) => value.id == id);
}
