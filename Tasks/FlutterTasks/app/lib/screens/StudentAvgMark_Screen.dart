import "package:flutter/material.dart";

class StudentMarksScreen extends StatelessWidget {
  const StudentMarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<double> marks1 = [12, 53, 23];
    List<double> marks2 = [43, 54, 65];
    double sum1 = 0, sum2 = 0;

    for (int j = 0; j < 3; j++) {
      sum1 += marks1[j];
      sum2 += marks2[j];
    }

    double avg1 = sum1 / 3;
    double avg2 = sum2 / 3;

    return Scaffold(
      appBar: AppBar(title: Text("Student Avg Marks")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text("1")),
                title: Text("Ali"),
                subtitle: Text("Roll No: BCS124"),
                trailing: Text("Avg: ${avg1.toStringAsFixed(2)}"),
              ),
            ),
            Card(
              child: ListTile(
                leading: CircleAvatar(child: Text("2")),
                title: Text("Hamza"),
                subtitle: Text("Roll No: BSAI243"),
                trailing: Text("Avg: ${avg2.toStringAsFixed(2)}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
