import "package:app/main.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  TextEditingController desc = TextEditingController();
  TextEditingController heading = TextEditingController();
  String status = "Open";
  String? editTaskid;
  Future<void> saveTask() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final data = {
      "heading": heading.text,
      "desc": desc.text,
      "status": status,
      "createdAt": FieldValue.serverTimestamp(),
    };
    final taskref = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("tasks");

    if (editTaskid == null) {
      await taskref.add(data);
    } else {
      await taskref.doc(editTaskid).update(data);
    }
    editTaskid = null;
  }

  Stream<QuerySnapshot> readTask() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("tasks")
        .orderBy("createdAt", descending: true)
        .snapshots();
  }

  Widget MyRadio(StateSetter setDialogState) {
    return Column(
      children: [
        RadioListTile<String>(
          value: "Open",
          title: Text("Open"),
          groupValue: status,
          onChanged: (val) {
            setDialogState(() {
              status = val!;
            });
          },
        ),
        RadioListTile<String>(
          value: "InProgress",
          title: Text("InProgress"),
          groupValue: status,
          onChanged: (val) {
            setDialogState(() {
              status = val!;
            });
          },
        ),
        RadioListTile<String>(
          value: "Done",
          title: Text("Done"),
          groupValue: status,
          onChanged: (val) {
            setDialogState(() {
              status = val!;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks List"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
            icon: Icon(Icons.home),
            tooltip: "Home",
          ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: readTask(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No task available"));
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final task = docs[index];
              return ListTile(
                title: Text(task["heading"]),
                subtitle: Text(task["desc"]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(task["status"]),
                    IconButton(
                      onPressed: () {
                        editTaskid = task.id;
                        heading.text = task["heading"];
                        desc.text = task["desc"];
                        status = task["status"];
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setDialogState) {
                                return AlertDialog(
                                  title: Text("Edit task"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: heading,
                                        decoration: InputDecoration(
                                          labelText: "Enter title",
                                        ),
                                      ),
                                      TextField(
                                        controller: desc,
                                        decoration: InputDecoration(
                                          labelText: "Enter detail",
                                        ),
                                      ),
                                      MyRadio(setDialogState),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        saveTask();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Save"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        task.reference.delete();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setDialogState) {
                  return AlertDialog(
                    title: Text("Add task"),
                    titleTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: heading,
                          decoration: InputDecoration(labelText: "Enter title"),
                        ),
                        TextField(
                          controller: desc,
                          decoration: InputDecoration(
                            labelText: "Enter detail",
                          ),
                        ),
                        MyRadio(setDialogState),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          saveTask();
                          Navigator.pop(context);
                        },
                        child: Text("Save"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
