void main(){
  int age=18;
  String nationality="Pakistani";

  if(age>=18 && nationality=="Pakistani"){
    print("You are eligible for cnic.");
  } 
  else{
    print("Sorry! Not eligible for cnic.");
  }


  age=20;
  String country="Pakistan";
  if(age>=20 && country=="Pakistan"){
    print("You are an adult and a Pakistani.");
  }
  else if(age>=20 && country!="Pakistan"){
    print("You are an adult and a foreigner.");
  }
  else{
    print("You are underage.");
  }
}