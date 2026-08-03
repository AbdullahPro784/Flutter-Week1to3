void main(){
  int age=18;
  String country="America";
  String name="Harris";
  bool CrimeRecord=false;
  int BankBalance=250000;

  if(age>=18){
    if(country=="America"){
      if(CrimeRecord==true){
        print("Criminals with previous crimes are not allowed.");
      }
      else{
        if(BankBalance>=250000){
          print("Welcome! Your visa is approved");
        }
        else{
          print("Sorry! You must have bank balance greater than 250k to be accepted... Submit urgetnly!");
        }
      }
    }
    else if(country=="Argentina"){
      print("You are not allowed to enter. Banned!");
    }
    else{
      print("Please submit your passport for processing...");
    }
  }
  else{
    print("Sorry! You must be over 18 to qualify! ");
  }

}