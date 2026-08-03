import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "list dynamic vs static",
      home: Scaffold(
        appBar: AppBar(title: Text("dynamic vs static")),
        body: List_Example(),
      ),
    );
  }
}

class List_Example extends StatelessWidget {
  List<String> names = ["Ali", "Musa", "Ahmad", "Harris", "Ryan", "Bakar"];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text("Static Lists: ", style: TextStyle(fontSize: 18)),
        Text("Item 1"),
        Text("Item 2"),
        Text("Item 3"),

        SizedBox(height: 20),

        Text(
          "Dynamic Lists",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        ...names.map((name) => Text(name)).toList(),
      ],
    );
  }
}
