import "package:flutter/material.dart";

class FoodScreen extends StatelessWidget {
  List<String> name = ["Noodles", "Cake", "Rice", "Curry", "Bread", "Soup"];
  List<double> price = [34.03, 53.4, 65.3, 12.2, 43.4, 41.2];
  List<String> category = [
    "Starter",
    "Sweet",
    "Main",
    "Main",
    "Starter",
    "Starter",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FOODY")),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text("${index + 1}")),
            title: Text(name[index]),
            subtitle: Text(category[index]),
            trailing: Text("${price[index]} \$"),
          );
        },
      ),
    );
  }
}
