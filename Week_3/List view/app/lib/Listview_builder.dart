import "package:flutter/material.dart";

void main() {
  runApp(Builder());
}

class Builder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Builder",
      home: Scaffold(
        appBar: AppBar(title: Text("Builder")),
        body: builderList(),
      ),
    );
  }
}

class builderList extends StatelessWidget {
  List<String> models = [
    "iPhone",
    "Samsung",
    "Lenovo",
    "Microsoft",
    "HP",
    "Fujistu",
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: models.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "${index + 1}. ${models[index]}",
            style: TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }
}
