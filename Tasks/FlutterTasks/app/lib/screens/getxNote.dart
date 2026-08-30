import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_ce_flutter.dart";
import "package:get/get.dart";

class ControllerNotes extends GetxController {
  late Box noteBox;
  var notes = <dynamic>[].obs;
  @override
  void onInit() {
    super.onInit();
    noteBox = Hive.box("NotesStorage");
    refreshNote();
  }

  void refreshNote() {
    notes.value = noteBox.keys.toList().reversed.toList();
  }

  Future<void> addNote(String title, String desc) async {
    await noteBox.add({"title": title, "description": desc});
    refreshNote();
  }

  void updateNote(int key, String title, String desc) {
    noteBox.put(key, {"title": title, "description": desc});
    refreshNote();
  }

  void delNote(int key) {
    noteBox.delete(key);
    refreshNote();
  }

  Map getNote(int key) => noteBox.get(key);
}

class GetxNote extends StatefulWidget {
  const GetxNote({super.key});

  @override
  State<GetxNote> createState() => _GetxNoteState();
}

class _GetxNoteState extends State<GetxNote> {
  final ControllerNotes controller = Get.put(ControllerNotes());

  void addNote() {
    TextEditingController title = TextEditingController();
    TextEditingController desc = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add new Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(hintText: "Enter note title"),
              ),
              TextField(
                controller: desc,
                decoration: InputDecoration(hintText: "Enter note description"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await controller.addNote(title.text, desc.text);
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void editNote(int key) {
    Map note = controller.getNote(key);

    TextEditingController title = TextEditingController(text: note["title"]);
    TextEditingController desc = TextEditingController(
      text: note["description"],
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update Note"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(hintText: "Enter update title"),
              ),
              TextField(
                controller: desc,
                decoration: InputDecoration(
                  hintText: "Enter update description",
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                controller.updateNote(key, title.text, desc.text);
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notex"),
        backgroundColor: Colors.indigo,
        titleTextStyle: TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
      body: Obx(() {
        final keys = controller.notes;
        return ListView.builder(
          padding: EdgeInsets.all(15),
          itemCount: keys.length,
          itemBuilder: (context, index) {
            final key = keys[index];
            Map note = controller.getNote(key);

            return Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(15),
                title: Text(
                  note["title"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Text(
                    note["description"],
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Icon(Icons.note, color: Colors.green),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        editNote(key);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.delNote(key);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addNote,
        label: Text("Add Note"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
