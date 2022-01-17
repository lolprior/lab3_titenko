import 'package:flutter/material.dart';
import 'package:my_instagram/models/PostList.dart';
import 'package:my_instagram/models/Story.dart';
import 'package:my_instagram/models/StoryList.dart';
// import 'package:my_instagram/pages/story_list.dart';
import 'package:provider/provider.dart';

class StoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stories = Provider.of<StoriesFeed>(context).stories;
    print(stories);
    return ListView(
      // physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        Stack(children: [
          StoryIcon(
            false,
            id: 0,
            width: 70,
            height: 70,
            radius: 50,
          ),
          Positioned(
            left: 60,
            bottom: 15,
            child: Icon(
              Icons.add_circle,
              size: 20,
            ),
          ),
        ]),
        Container(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: stories.length,
            itemBuilder: (context, index) => Hero(
              tag: stories[index].id,
              child: GestureDetector(
                child: StoryIcon(
                  false,
                  id: index,
                  width: 70,
                  height: 70,
                  radius: 50,
                ),
                onTap: () {
                  Text("Заглушка");
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}

class StoryIcon extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final int id;
  bool isForPost = false;

  StoryIcon(this.isForPost,
      {Key key, this.height, this.width, this.radius, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<StoriesFeed>(builder: (context, story, child) {
      final storyById = story.getElementById(id);
      return Column(
        children: [
          Container(
            margin: !isForPost
                ? EdgeInsets.only(left: 15, top: 10)
                : EdgeInsets.only(left: 15),
            width: width,
            height: height,
            decoration: (storyById.active == true)
                ? BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(storyById.userAvatar),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(new Radius.circular(radius)),
                    border: Border.all(width: 4.0, color: Colors.red),
                  )
                : BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(storyById.userAvatar),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(new Radius.circular(radius)),
                  ),
          ),
          !isForPost
              ? Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Text(storyById.nickname))
              : Padding(padding: EdgeInsets.only(left: 18)),
        ], // border: Border.all(width: 4.0, color: Colors.red),
      );
    });
  }
}
