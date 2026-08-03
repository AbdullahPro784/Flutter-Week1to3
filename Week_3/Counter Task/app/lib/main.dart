import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Scaffold(
        appBar: AppBar(title: Text("My App")),
        body: CounterScreen(),
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int count = 0, count1 = 0;

  void increaseCount() {
    setState(() {
      count = count + 1;
    });
  }

  void reset() {
    setState(() {
      count = 0;
    });
  }

  void decrease() {
    setState(() {
      count = count - 1;
    });
  }

  void increaseCount1() {
    setState(() {
      count1 = count1 + 1;
    });
  }

  void reset1() {
    setState(() {
      count1 = 0;
    });
  }

  void decrease1() {
    setState(() {
      count1 = count1 - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Count: $count", style: TextStyle(fontSize: 30)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: increaseCount,
            child: Text("Increase count", style: TextStyle(color: Colors.blue)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: reset,
            child: Text("Reset count", style: TextStyle(color: Colors.red)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: count == 0 ? null : decrease,
            child: Text("Decrease Count", style: TextStyle(color: Colors.pink)),
          ),
          IconButton(onPressed: increaseCount, icon: Icon(Icons.add)),
          IconButton(onPressed: decrease, icon: Icon(Icons.remove)),

          Text("Count: $count1", style: TextStyle(fontSize: 30)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: increaseCount1,
            child: Text("Increase count", style: TextStyle(color: Colors.blue)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: reset1,
            child: Text("Reset count", style: TextStyle(color: Colors.red)),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: count1 == 0 ? null : decrease1,
            child: Text("Decrease Count", style: TextStyle(color: Colors.pink)),
          ),
          IconButton(onPressed: increaseCount1, icon: Icon(Icons.add)),
          IconButton(onPressed: decrease1, icon: Icon(Icons.remove)),
        ],
      ),
    );
  }
}
