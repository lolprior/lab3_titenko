import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_instagram/models/PostList.dart';
import 'package:provider/provider.dart';
import 'package:my_instagram/models/Post.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:my_instagram/models/user_model.dart';
import 'package:my_instagram/models/StoryList.dart';
import 'package:my_instagram/widgets/message.dart';
import 'package:my_instagram/widgets/post.dart';
import 'package:my_instagram/pages/comment_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_instagram/services/api_service.dart';

SharedPreferences sp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  // await sp.clear();
  //used singleton for this service
  ApiUserService apiService = ApiUserService.instance;
  // APIFeedService apiFeedService = APIFeedService();

  //check_friends_status can be only true or null if wasn't created
  // Віджет фюче білдер , в білдері є ряд перевірок який приймає контекст а другий поточний стан виконання фьючер це снапшот
  // якщо снапшот завершився
  runApp(FutureBuilder(
      future: apiService.getUser(1),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        print(snapshot.data);
        if (!snapshot.hasData) {
          return MaterialApp(
              // theme: ThemeData.dark(),
              title: "Waiting for data",
              home: Center(child: CircularProgressIndicator()));
        } else {
          return MultiProvider(providers: [
            ChangeNotifierProvider<User>(create: (context) {
              print(snapshot.data);
              User user = snapshot.data;
              return user;
            }),
            ChangeNotifierProvider<FeedModelProvider>(
              create: (context) => FeedModelProvider(),
            ),
            ChangeNotifierProvider<StoriesFeed>(
              create: (context) => StoriesFeed(),
            ),
          ], child: MyApp());
        }
      }));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("sdfsddsf");
    return MaterialApp(
        theme: ThemeData.dark(),
        title: "My implementation",
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => Home());
              // Виконується перехід по імені віджета, класу
              break;
            case '/comment':
              var arguments = settings.arguments as Map<String, PostModel>;
              return MaterialPageRoute(
                  builder: (BuildContext context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider.value(
                                value: arguments['post'])
                          ],
                          builder: (context, child) =>
                              CommentPage(id: arguments['post'].id)));
              // Виконується перехід з передачою параметра в конструктор віджета
              break;
          }
        });
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              // tooltip: 'Show Snackbar',
              onPressed: () {
                Text("Заглушка");
              },
              color: Colors.black,
              iconSize: 30,
            ),
            Text(
              "Instagram",
              style: GoogleFonts.lobster(fontSize: 25),
            ),
            Transform.rotate(
                angle: -35 * pi / 180,
                child: IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  // tooltip: 'Show Snackbar',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                  color: Colors.black,
                )),
          ],
        ),
      ),
      body: MainFeed(),
    );
  }
}
