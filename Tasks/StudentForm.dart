import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App Task",
      home: Scaffold(
        appBar: AppBar(title: Text("Tasks")),
        body: FormStudent(),
      ),
    );
  }
}

class FormStudent extends StatefulWidget {
  @override
  _FormStudentState createState() => _FormStudentState();
}

class _FormStudentState extends State<FormStudent> {
  TextEditingController name = TextEditingController();
  TextEditingController father = TextEditingController();
  String gender = "null";
  bool python = false;
  bool java = false;
  bool kotlin = false;
  String city = "Lahore";

  void Submit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          name: name.text,
          father: father.text,
          gender: gender,
          city: city,
          python: python,
          java: java,
          kotlin: kotlin,
        ),
      ),
    );
  }

  Widget MyRadio(String title, String value) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: gender,
      onChanged: (val) {
        setState(() {
          gender = val!;
        });
      },
    );
  }

  Widget MyCheckbox(String title, bool value) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: (val) {
        setState(() {
          if (title == "Python") {
            python = val!;
          } else if (title == "Kotlin") {
            kotlin = val!;
          } else if (title == "Java") {
            java = val!;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FORM")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: father,
              decoration: InputDecoration(labelText: "Father Name"),
            ),
            SizedBox(height: 10),

            Text("Select gender: "),

            MyRadio("male", "male"),
            MyRadio("women", "women"),

            Text("Skills choose"),
            MyCheckbox("Python", python),
            MyCheckbox("Java", java),
            MyCheckbox("Kotlin", kotlin),

            Text("Select City"),

            DropdownButton<String>(
              value: city,
              items: [
                DropdownMenuItem(value: "Karachi", child: Text("Karachi")),
                DropdownMenuItem(value: "Lahore", child: Text("Lahore")),
                DropdownMenuItem(value: "Okara", child: Text("Okara")),
              ],

              onChanged: (value) {
                setState(() {
                  city = value!;
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: Submit, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  String name, father, gender, city;
  bool python, java, kotlin;

  ResultScreen({
    required this.name,
    required this.father,
    required this.gender,
    required this.city,
    required this.python,
    required this.java,
    required this.kotlin,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text("Name"),
                  subtitle: Text(name),
                ),
                ListTile(
                  leading: Icon(Icons.arrow_forward),
                  title: Text("Father Name"),
                  subtitle: Text(father),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Gender"),
                  subtitle: Text(gender),
                ),
                ListTile(
                  leading: Icon(Icons.house),
                  title: Text("City"),
                  subtitle: Text(city),
                ),
                ListTile(
                  leading: Icon(Icons.money),
                  title: Text("Skills"),
                  subtitle: Text(
                    "Python: $python\nJava:$java\nKotlin: $kotlin\n",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
