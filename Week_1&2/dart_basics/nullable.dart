import "dart:io";



late String city;
void main(){
  String? name;
  
  print("Name is $name");

  print("Name is $name");
  print(name?? "ali");

  name="Harris";
  print(name ?? "Ali");

  int? age;
  age ??=19;
  print(age);


  city="Lahore";
  print(city);


}