import "dart:io";

int avg_cal(int sum){
  return sum~/6;
}

void Square(int n){
  int sq=n*n;
  print("Square is ${sq}");
}

int Sum(int a,int b)=> a+b;

int add(int a,int b)=> a+b;

void Grading(String n){
  switch(n){
    case "A":
      print("Grade is A.");

    case "B":
      print("Grade is B");

    case "C":
      print("Grade is C");

    case "D": 
      print("Grade is D");
  }
}

String OddEven(int x)=> x%2==0 ? "Even":"Odd";

//optional position parameters
void Intro(String name,[int? age]){
  if(age!=null){
    print("Hello! My name is $name and im $age ");
  }
  else{
    print("Hello! My name is $name");
  }
}

//default parameters
void showMessage(String msg, [String comments="Goodbye!"]){
  print("$msg $comments");
}
//anonymous function
var hello=(String nameCountry){
  print("Hello from $nameCountry.");
};

var num=(int number)=>print("Square is ${number*number}");
void main(){
  int maths=100, urdu=54,comp=65,isl=76,physics=37,chem=85, percent;
  int sum=maths+urdu+comp+isl+physics+chem;

  percent=avg_cal(sum);

  if(percent>=80){
    print("Good job! Your percentage is ${percent}");
  }
  else{
    print("Work harder! Your percentage is ${percent}");
  }

  Square(9);
  

  Grading("A");

  print(Sum(9,10));
  print(OddEven(10));
  print(add(19,11));
  hello("US");
  num(2);
  Intro("Ahmad",23);
  Intro("Ilyas");
  showMessage("Hello World!");
}