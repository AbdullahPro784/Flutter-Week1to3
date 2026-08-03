class Student{
  String name,rollNum;
  double marks;
  
  Student(this.name,this.rollNum,this.marks){}

  double calculateAverage(){
    double avg=marks/3;
    return avg;
  }
  void displayInfo(double avg){
    print("$name $rollNum your average is $avg");
  }
}
void main(){
  List<double> marks1=[12,53,23];
  List<double> marks2=[43,54,65];
  double sum1=0,sum2=0,avg1=0,avg2=0;
  for(int j=0;j<3;j++){
    sum1+=marks1[j];
    sum2+=marks2[j];
  }
  
  Student std1=Student("Ali","BCS124",sum1);
  Student std2=Student("Hamza","BSAI243",sum2);
  avg1=std1.calculateAverage();
  std1.displayInfo(avg1);
  
  avg2=std2.calculateAverage();
  std2.displayInfo(avg2);
  
}