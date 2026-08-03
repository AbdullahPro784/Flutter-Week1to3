class Vehicle{
  String type;

  Vehicle(this.type){}

  void TypeVec(){
    print("The vehicle is of type ${type}.");
  }
}

class Car extends Vehicle{
  String model;

  Car(this.model,String type):super(type){}

  void showModel(){
    print("Car model is ${model}");
  }
}


class Mobile{
  String model;
  Mobile(this.model){}

  void showType(){
    print("The ${model} is type of mobile");
  }

  void showName(){
    print("Mobile Phone.");
  }
}
class Apple extends Mobile{
  
  Apple(String model):super(model);

  void showModel(){
    print("The model of apple mobile is ${model}");
  }
  @override
  void showName(){
    print("Overrided: Mobile iphone 6.");
  }
}
void main(){
  Car c=Car("Civic","Hatchback");
  c.showModel();
  c.TypeVec();

  Apple A=Apple("iphone 6");
  A.showType();
  A.showModel();
  A.showName();
}