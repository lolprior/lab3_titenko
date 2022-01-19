import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_instagram/models/PostList.dart';
import 'package:my_instagram/models/Post.dart';
import 'package:my_instagram/models/user_model.dart';
import 'package:my_instagram/models/comment_model.dart';
import 'stories.dart';
import '../main.dart';

import 'package:provider/provider.dart';

class Post extends StatefulWidget {
  final int id;

  Post({Key key, this.id}) : super(key: key);

  @override
  _PostState createState() => _PostState();

  static Widget buildDescription(context, String nickname, String description) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: nickname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  wordSpacing: 5,
                )),
            TextSpan(text: "   "),
            TextSpan(
              text: description,
            )
          ]))
        ],
      ),
    );
  }
}

class _PostState extends State<Post> {
  String lastCommet;

  @override
  Widget build(BuildContext context) {
    // final post = context.read<FeedModelProvider>().getElementById(id);
    TextEditingController commentController = TextEditingController();
    final post = Provider.of<PostModel>(context);
    final user = Provider.of<User>(context);
    // User userByIdData;
    // if (user.friends.length != 2)
    //   return Center(child: CircularProgressIndicator());
    // else
    //   userByIdData = user.getFriendById(post.userId);

    // final postId = post.getElementById(id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                StoryIcon(
                  true,
                  id: widget.id,
                  height: 50,
                  width: 50,
                  radius: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(post.nickname,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.more_horiz,
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            child: InkWell(
              onDoubleTap: () {
                post.changeLikeStatus();
                sp.setBool(post.id.toString(), post.like);
              },
              child: Image(
                image: AssetImage(post.mainPhotoUrl),
                fit: BoxFit.fitWidth,
              ),
            )),
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<PostModel>(builder: (context, post, child) {
                  return IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: (post.like ||
                              (sp.getBool(post.id.toString()) ?? false))
                          ? Colors.red
                          : Colors.white,
                      size: 25,
                    ),
                    onPressed: () {
                      post.changeLikeStatus();
                      sp.setBool(post.id.toString(), post.like);
                    },
                    // tooltip: 'Show Snackbar',
                    color: Colors.black,
                  );
                }),
                IconButton(
                    icon: Icon(
                      CupertinoIcons.chat_bubble,
                      size: 35,
                    ),
                    onPressed: () {
                      // addCommetPage(context, post);
                    }),
                Transform.rotate(
                  angle: -24 * pi / 180,
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 30,
                    ),
                    // tooltip: 'Show Snackbar',
                    onPressed: () {
                      Text("Заглушка");
                      // scaffoldKey.currentState.showSnackBar(snackBar);
                    },
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(
                  Icons.archive_outlined,
                  color: post.archive ? Colors.grey : Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  post.changeArchiveStatus();
                },
              ),
            )
          ]),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(bottom: 6, left: 15),
            child: Text(
              ("${((sp.getInt(post.id.toString() + 'count') ?? 0))} likes"),
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 6, left: 15),
            child:
                Post.buildDescription(context, post.nickname, post.description),
          ),
          Padding(
            child: GestureDetector(
              child: Text(
                "View all ${post.comments.length} comments",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              onTap: () async {
                var lastCommetString = await Navigator.pushNamed(
                    context, '/comment',
                    arguments: {'post': post}) as String;
                setState(() {
                  lastCommet = lastCommetString;
                });
                // addCommetPage(context, post);
              },
            ),
            padding: EdgeInsets.only(bottom: 0, left: 15),
          ),
          lastCommet != null
              ? Container(
                  child: Row(children: [
                    Text(
                      user.nickname,
                      style: TextStyle(fontSize: 15),
                    ),
                    Container(width: 10),
                    Text(lastCommet, style: TextStyle(fontSize: 16)),
                  ]),
                  padding: EdgeInsets.only(left: 18, top: 10, bottom: 10),
                )
              : Container(),
          Row(children: [
            StoryIcon(
              true,
              id: widget.id,
              height: 30,
              width: 30,
              radius: 40,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: commentController,
                decoration: InputDecoration(
                  hintText: 'Add comment',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                ),
                onSubmitted: (value) {
                  String message = commentController.text;
                  if (message != '')
                    post.addComment(
                        Comment(post.id, message, post.id, post.id));
                },
              ),
            )
          ]),
          Padding(
              padding: EdgeInsets.only(bottom: 6, left: 15),
              child: Text(
                "31 minutes ago",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )),
        ]),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

// class Post extends StatelessWidget {
//   final int id;

//   Post({Key key, this.id}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final post = context.read<FeedModelProvider>().getElementById(id);
//     final post = Provider.of<PostModel>(context);
//     // final currentPost =
//     //     Provider.of<FeedModelProvider>(context).getElementById(id);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 50,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             // mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(children: [
//                 StoryIcon(
//                   true,
//                   id: id,
//                   height: 50,
//                   width: 50,
//                   radius: 30,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 12),
//                   child: Text(post.nickname,
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                 ),
//               ]),
//               Padding(
//                 padding: EdgeInsets.only(right: 20),
//                 child: Icon(
//                   Icons.more_horiz,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//             margin: EdgeInsets.only(top: 10, bottom: 10),
//             width: double.infinity,
//             child: InkWell(
//               onDoubleTap: () {
//                 post.changeLikeStatus();
//               },
//               child: Image(
//                 image: AssetImage(post.mainPhotoUrl),
//                 fit: BoxFit.fitWidth,
//               ),
//             )),
//         Container(
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Consumer<PostModel>(builder: (context, post, child) {
//                   return IconButton(
//                     icon: Icon(
//                       Icons.favorite,
//                       color: post.like ? Colors.red : Colors.white,
//                       size: 25,
//                     ),
//                     onPressed: () {
//                       post.changeLikeStatus();
//                       // scaffoldKey.currentState.showSnackBar(snackBar);
//                     },
//                     // tooltip: 'Show Snackbar',

//                     color: Colors.black,
//                   );
//                 }),
//                 IconButton(
//                     icon: Icon(
//                       CupertinoIcons.chat_bubble,
//                       size: 35,
//                     ),
//                     onPressed: () {
//                       Text("Заглушка");
//                     }),
//                 Transform.rotate(
//                   angle: -24 * pi / 180,
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                     // tooltip: 'Show Snackbar',
//                     onPressed: () {
//                       Text("Заглушка");
//                       // scaffoldKey.currentState.showSnackBar(snackBar);
//                     },
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 10),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.archive_outlined,
//                   color: post.archive ? Colors.grey : Colors.white,
//                   size: 30,
//                 ),
//                 onPressed: () {
//                   post.changeArchiveStatus();
//                 },
//               ),
//             )
//           ]),
//         ),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Padding(
//             padding: EdgeInsets.only(bottom: 6, left: 15),
//             child: Text(
//               ("${post.likesCount} likes"),
//               textAlign: TextAlign.left,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 6, left: 15),
//             child: buildDescription(context, post),
//           ),
//           Padding(
//             child: GestureDetector(
//               child: Text(
//                 "View all 2 comments",
//                 style: TextStyle(color: Colors.grey, fontSize: 16),
//               ),
//               onTap: () {
//                 Text("Заглушка");
//               },
//             ),
//             padding: EdgeInsets.only(bottom: 0, left: 15),
//           ),
//           Row(children: [
//             // !- TODO: replace StoryIcon data to model
//             StoryIcon(
//               true,
//               id: id,
//               height: 30,
//               width: 30,
//               radius: 40,
//             ),
//             // SizedBox(
//             //   width: 300,
//             //   child: TextField(
//             //     controller: commentController,
//             //     decoration: InputDecoration(
//             //       hintText: 'Add comment',
//             //       border: InputBorder.none,
//             //       contentPadding:
//             //           EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//             //     ),
//             //     onSubmitted: (value) {
//             //       String message = commentController.text;
//             //       if (message != '') post.addComment(Comment(message));
//             //     },
//             //   ),
//             // )
//           ]),
//           Padding(
//               padding: EdgeInsets.only(bottom: 6, left: 15),
//               child: Text(
//                 "31 minutes ago",
//                 style: TextStyle(fontSize: 12, color: Colors.grey),
//               )),
//         ]),
//         SizedBox(
//           height: 10,
//         )
//       ],
//     );
//   }

// void addCommetPage(context, PostModel post) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (BuildContext context) => MultiProvider(
//           providers: [ChangeNotifierProvider.value(value: post)],
//           builder: (context, child) => CommentPage(
//                 id: post.id,
//               )),
//     ),
//   );
// }

//   static Widget buildDescription(context, PostModel post) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           RichText(
//               text: TextSpan(children: <TextSpan>[
//             TextSpan(
//                 text: post.nickname,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                   wordSpacing: 5,
//                 )),
//             TextSpan(text: "   "),
//             TextSpan(
//               text: post.description,
//             )
//           ]))
//         ],
//       ),
//     );
//   }
// }

class MainFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postsData = Provider.of<FeedModelProvider>(context);
    List<PostModel> posts = postsData.getAllpPosts();

    return Column(children: [
      SizedBox(height: 100, child: StoriesList()),
      Divider(
        color: Colors.white,
      ),
      Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: postsData.posts.length,
              itemBuilder: (context, index) {
                // print(postsData.posts.length);
                // print(index);
                return MultiProvider(providers: [
                  ChangeNotifierProvider.value(
                    value: postsData.posts[index],
                  )
                ], child: Post(id: index));
              })),
    ]);
  }
}
