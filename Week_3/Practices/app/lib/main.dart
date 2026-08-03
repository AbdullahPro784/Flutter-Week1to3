import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

void change() {
  print("Clicked");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Page",
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter Page")),
        body: MyApp1(),
      ),
    );
  }
}

class MyApp1 extends StatefulWidget {
  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Button..", style: TextStyle(color: Colors.red)),
          SizedBox(height: 20),
          ElevatedButton(onPressed: change, child: Text("Change text")),
        ],
      ),
    );
  }
}
