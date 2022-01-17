import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:my_instagram/widgets/message_input.dart';

final List<Tab> tabs = <Tab>[
  Tab(
    text: 'Primary',
    // child: PrimaryMessages,
  ),
  Tab(
    text: 'General',
    // child: PrimaryMessages,
  ),
];

class ChatScreen extends StatefulWidget {
  @override
  ChatScreenState createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatelessWidget(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // The Builder widget is used to have a different BuildContext to access
      // closest DefaultTabController.
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "st.l1ght",
              ),
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(Icons.video_call)),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.note_sharp),
              )
            ],
            bottom: TabBar(
              tabs: tabs,
            ),
          ),
          body: TabBarView(
            children: tabs.map((Tab tab) {
              if (tab.text == "Primary")
                return PrimaryMessages();
              else
                return Center(
                  child: Text("General"),
                );
            }).toList(),
          ),
        );
      }),
    );
  }
}

class Message extends StatelessWidget {
  const Message({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('Go back!'),
      ),
    );
  }
}

class PrimaryMessages extends StatelessWidget {
  const PrimaryMessages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dummyData.length,
      itemBuilder: (context, i) => Column(
        children: <Widget>[
          Divider(
            height: 10.0,
          ),
          ListTile(
            leading: CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage(dummyData[i].avatarUrl),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  dummyData[i].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  dummyData[i].time,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                dummyData[i].message,
                style: TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
