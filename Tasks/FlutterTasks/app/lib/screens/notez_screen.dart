import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_ce_flutter.dart";

class NotezScreen extends StatefulWidget {
  const NotezScreen({super.key});

  @override
  State<NotezScreen> createState() => _NotezScreenState();
}

class _NotezScreenState extends State<NotezScreen> {
  late Box noteBox;

  @override
  void initState() {
    super.initState();
    noteBox = Hive.box("NotesStorage");
  }

  void addNote() {
    TextEditingController title = TextEditingController();
    TextEditingController description = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(hintText: "Enter title: "),
              ),
              TextField(
                controller: description,
                decoration: InputDecoration(hintText: "Enter description"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                noteBox.add({
                  "title": title.text,
                  "description": description.text,
                });

                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void editNote(int key) {
    Map note = noteBox.get(key);

    TextEditingController title = TextEditingController(text: note["title"]);
    TextEditingController description = TextEditingController(
      text: note["description"],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: title),
              TextField(controller: description),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                noteBox.put(key, {
                  "title": title.text,
                  "description": description.text,
                });
                setState(() {});
                Navigator.pop(context);
              },
              child: Text("Update confirm"),
            ),
          ],
        );
      },
    );
  }

  void deleteNote(int key) {
    noteBox.delete(key);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final keys = noteBox.keys.toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Notez"),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          fontSize: 30,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          int key = keys[index];
          Map note = noteBox.get(key);

          return Card(
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.all(12),
              title: Text(
                note["title"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  note["description"],
                  style: TextStyle(fontSize: 15),
                ),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.note, color: Colors.yellow),
              ),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Edit"),
                    onTap: () {
                      editNote(key);
                    },
                  ),
                  PopupMenuItem(
                    child: Text("delete"),
                    onTap: () {
                      deleteNote(key);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: addNote,
        icon: Icon(Icons.add),
        label: Text("Make new note"),
      ),
    );
  }
}
