import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ListView",
      home: Scaffold(
        appBar: AppBar(title: Text("Lists")),
        body: ListView(
          children: [
            Text("Text 1"),
            Text("Text 2"),
            Text("Text 3"),
            Text("List 1"),
            Text("List 2"),
            Text("List 3"),
            Text("View 1"),
            Text("View 2"),
            Text("View 3"),
            ElevatedButton(onPressed: null, child: Text("Button 1")),
            ElevatedButton(onPressed: null, child: Text("Button 2")),
            ElevatedButton(onPressed: null, child: Text("Button 3")),
          ],
        ),
      ),
    );
  }
}
