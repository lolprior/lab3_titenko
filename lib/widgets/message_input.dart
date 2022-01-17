class MessageModel {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;

  MessageModel({this.name, this.message, this.time, this.avatarUrl});
}

List<MessageModel> dummyData = [
  MessageModel(
      name: "example1",
      message: "example1example1 example1",
      time: "12:00",
      avatarUrl:
          "assets/images/first (1).png"),
  MessageModel(
      name: "example2",
      message: "example1 example1 example1",
      time: "17:00",
      avatarUrl:
          "assets/images/first (2).png"),
  MessageModel(
      name: "example3",
      message: "example3",
      time: "4:00",
      avatarUrl:
          "assets/images/first (3).png"),
  MessageModel(
      name: "example4",
      message: "example4 example1 example1",
      time: "11:12",
      avatarUrl:
          "assets/images/first (4).png"),
  MessageModel(
      name: "example5",
      message: "example1example1 example15",
      time: "12:43",
      avatarUrl:
          "assets/images/first (1).png"),
  MessageModel(
      name: "example6",
      message: "example6 example16 example16",
      time: "01:23",
      avatarUrl:
          "assets/images/first (2).png"),
];