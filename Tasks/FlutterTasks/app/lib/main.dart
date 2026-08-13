import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_ce_flutter.dart";
import "screens/FoodApp_Screen.dart";
import "screens/NewsApp_Screen.dart";
import "screens/notez_screen.dart";
import "screens/StudentAvgMark_Screen.dart";
import "screens/StudentFormScreen.dart";
import "package:firebase_core/firebase_core.dart";
import "screens/firebase_options.dart";
import "screens/Firebase_authScreen.dart";
import "screens/FireStore_Screen.dart";
import "screens/Firebase_profile_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox("NotesStorage");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tasks Screens",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectIndex = 0;

  List<Widget> screens = [
    FoodScreen(),
    NewsScreen(),
    NotezScreen(),
    StudentMarksScreen(),
    FormStudent(),
    AuthScreen(),
    Firestore(),
    ProfileScreen(),
  ];

  List<String> namesScreens = [
    "Task1-Food App",
    "Task2-News App",
    "Task3-Notez App",
    "Task4-Marks Calculate App",
    "Task5-Student Form App",
    "Task6-Authentication Firebase App",
    "Task7-FireStore Firebase App",
    "Task8-Firebase Profile Screen App",
  ];

  List<IconData> screenIcons = [
    Icons.fastfood,
    Icons.newspaper,
    Icons.school,
    Icons.assignment,
    Icons.note,
    Icons.lock,
    Icons.store,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(namesScreens[selectIndex]),
        backgroundColor: Colors.cyan,
        titleTextStyle: TextStyle(
          fontSize: 23,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text("My Task List", style: TextStyle(fontSize: 20)),
            ),
            ListTile(
              leading: Icon(screenIcons[0]),
              title: Text(namesScreens[0]),
              onTap: () {
                setState(() {
                  selectIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(screenIcons[1]),
              title: Text(namesScreens[1]),
              onTap: () {
                setState(() {
                  selectIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(screenIcons[2]),
              title: Text(namesScreens[2]),
              onTap: () {
                setState(() {
                  selectIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(screenIcons[3]),
              title: Text(namesScreens[3]),
              onTap: () {
                setState(() {
                  selectIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(screenIcons[4]),
              title: Text(namesScreens[4]),
              onTap: () {
                setState(() {
                  selectIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(screenIcons[5]),
              title: Text(namesScreens[5]),
              onTap: () {
                setState(() {
                  selectIndex = 5;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(screenIcons[6]),
              title: Text(namesScreens[6]),
              onTap: () {
                setState(() {
                  selectIndex = 6;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(screenIcons[7]),
              title: Text(namesScreens[7]),
              onTap: () {
                setState(() {
                  selectIndex = 7;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: screens[selectIndex],
    );
  }
}
