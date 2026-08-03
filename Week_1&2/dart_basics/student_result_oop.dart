class Student{
  String name;
  int marks;

  Student(this.name,this.marks);

  void calculateGrade(){
    if(marks>=40){
      print("$name Your Grade is A");
    }
    else if(marks>=30){
      print("$name Your Grade is B");
    }
    else if(marks>=20){
      print("$name Your Grade is C");
    }
    else if(marks>=10){
      print("$name Your Grade is D");
    }
    else{
      print("You are failed ");
    }
  }
}
class PGStudent extends Student{
  PGStudent(String name,int marks):super(name,marks);
}
void main(){

  List<String> names=["Ali","Ahmad","Zubair","Hamza","Imran"];
  List<int> marks=[20,25,25,42,12];
  PGStudent P;

  List<Student> students=[];
  for(int i=0;i<5;i++){
    students.add(PGStudent(names[i],marks[i]));
  }
  for(var student in students){
    student.calculateGrade();
  }
  
}