class Person{
  //member variables 
  String name;
  int age;

  //constructor
  Person(this.name,this.age){}

  //member functions
  //getter
  String getName(){
    return name;
  }
  int getAge(){
    return age;
  }
  void Hello(){
    print("Hello i am ${name} and im ${age}.");
  }
}

class Account{
  double _balance,_amnt;

  Account(this._balance,this._amnt){}

  double deposit(){
    return _balance+=_amnt;
  }
  double withdraw(){
    return _balance-=_amnt;
  }
}
void main(){
  Person P;
  P=Person("Saif",19);
  print("Name: ${P.getName()}");
  print("Age: ${P.getAge()}");
  P.Hello();

  Account A;
  // balance, amount
  A=Account(10000,2000);
  print("Deposited New Amount is:  ${A.deposit()}.");
  print("Withdraw ${A.withdraw()}");
  print("Withdraw ${A.withdraw()}");
}