import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_ce_flutter.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class NoteNotifier extends Notifier<List<dynamic>> {
  late Box noteBox;

  @override
  List<dynamic> build() {
    noteBox = Hive.box("NotesStorage");
    return noteBox.keys.toList().reversed.toList();
  }

  void refreshNote() {
    state = noteBox.keys.toList().reversed.toList();
  }

  Future<void> addNote(String title, String desc) async {
    await noteBox.add({"title": title, "description": desc});
    refreshNote();
  }

  Future<void> updateNote(int key, String title, String desc) async {
    await noteBox.put(key, {"title": title, "description": desc});
    refreshNote();
  }

  Future<void> delNote(int key) async {
    await noteBox.delete(key);
    refreshNote();
  }

  Map getNote(int key) {
    return noteBox.get(key);
  }
}

final noteProvidor = NotifierProvider<NoteNotifier, List<dynamic>>(
  NoteNotifier.new,
);

class RiverpodNote extends ConsumerWidget {
  const RiverpodNote({super.key});
  void addNote(BuildContext context, WidgetRef ref) {
    final title = TextEditingController();
    final desc = TextEditingController();

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
                await ref
                    .read(noteProvidor.notifier)
                    .addNote(title.text, desc.text);

                if (context.mounted) {
                  Navigator.pop(context);
                }
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

  void editNote(BuildContext context, WidgetRef ref, int key) {
    final note = ref.read(noteProvidor.notifier).getNote(key);

    final title = TextEditingController(text: note["title"]);
    final desc = TextEditingController(text: note["description"]);

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
              onPressed: () async {
                await ref
                    .read(noteProvidor.notifier)
                    .updateNote(key, title.text, desc.text);
                if (context.mounted) {
                  Navigator.pop(context);
                }
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
  Widget build(BuildContext context, WidgetRef ref) {
    final keys = ref.watch(noteProvidor);
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(15),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          final key = keys[index];
          final note = ref.read(noteProvidor.notifier).getNote(key);

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
                  note["description"] ?? "",
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
                      editNote(context, ref, key);
                    },
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () async {
                      await ref.read(noteProvidor.notifier).delNote(key);
                    },
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          addNote(context, ref);
        },
        label: Text("Add Note"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
