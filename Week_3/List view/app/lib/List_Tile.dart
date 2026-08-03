import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ListTile",
      home: Scaffold(
        appBar: AppBar(title: Text("List Tile")),
        body: TileList(),
      ),
    );
  }
}

class TileList extends StatelessWidget {
  List<String> Vendor = ["MSI", "ASUS", "INNO", "COLORFUL", "PNY"];
  List<String> Models = [
    "GTX 1000",
    "GTX 1600",
    "RTX 2000",
    "RTX 3000",
    "RX 500",
    "RX 5000",
    "RX 6000",
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Vendor.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.account_balance),
          title: Text(Vendor[index]),
          subtitle: Text(Models[index]),
          trailing: Icon(Icons.forward),
          onTap: () {
            print("Clicked on ${Vendor[index]}");
          },
        );
      },
    );
  }
}
