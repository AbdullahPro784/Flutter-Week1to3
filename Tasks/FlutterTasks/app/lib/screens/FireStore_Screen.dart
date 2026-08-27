import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "firebase_options.dart";

class Firestore extends StatelessWidget {
  final refUser = FirebaseFirestore.instance.collection("users");

  Firestore({super.key});

  Future<void> addUser() async {
    await refUser.add({
      "email": "test${DateTime.now().millisecondsSinceEpoch}@example.com",
      "age": 30,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateAge(String docId, int newAge) async {
    await refUser.doc(docId).update({"age": newAge});
  }

  Future<void> deleteUser(String docId) async {
    await refUser.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FireStore data")),
      floatingActionButton: FloatingActionButton(
        onPressed: addUser,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: refUser.orderBy("createdAt", descending: true).snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return Center(child: Text("No users added. Data empty"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;

              return ListTile(
                title: Text(data["email"] ?? "No avaiable email"),
                subtitle: Text("Age ${data["age"] ?? "No available age"}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () =>
                          updateAge(doc.id, (data['age'] ?? 0) + 1),
                      icon: Icon(Icons.add_circle_outline),
                    ),
                    IconButton(
                      onPressed: () => deleteUser(doc.id),
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
