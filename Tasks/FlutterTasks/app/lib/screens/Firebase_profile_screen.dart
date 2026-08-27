import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  final TextEditingController bio = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    age.dispose();
    bio.dispose();
    super.dispose();
  }

  void msgDisplay(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  Future<void> submit() async {
    if (name.text.trim().isEmpty ||
        age.text.trim().isEmpty ||
        bio.text.trim().isEmpty) {
      msgDisplay("Enter all fields");
      return;
    }

    try {
      await FirebaseFirestore.instance.collection("users").add({
        "name": name.text.trim(),
        "age": int.tryParse(age.text.trim()) ?? 0,
        "bio": bio.text.trim(),
        "createdAt": FieldValue.serverTimestamp(),
      });
      name.clear();
      age.clear();
      bio.clear();
      msgDisplay("Successfully saved");
    } catch (e) {
      msgDisplay("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FireStore Profile"), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: "Enter name",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.add),
                    ),
                  ),
                  SizedBox(height: 13),
                  TextField(
                    controller: age,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: "Enter age",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.cake),
                    ),
                  ),
                  SizedBox(height: 13),
                  TextField(
                    controller: bio,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Enter bio",
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 13),
                  ElevatedButton(
                    onPressed: () => submit(),
                    child: Padding(
                      // ADD padding for a chunkier button
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text("Save Info"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Text(
              "Users",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .orderBy("createdAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text("No data added."));
                  }
                  final users = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index].data() as Map<String, dynamic>;

                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              user["name"].toString()[0].toUpperCase(),
                            ),
                          ),
                          title: Text(user["name"] ?? "null"),

                          subtitle: Text(
                            "Age: ${user["age"] ?? "null"}\n"
                            "${user["bio"] ?? "null"}",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
