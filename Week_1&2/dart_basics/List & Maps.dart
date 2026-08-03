void main(){
    List<String> names=["Ali","Zubair","Ahmad"];
    List<int> ages=[1,2,3,4,5,6,7,8,9,10];
    List<bool> isStudent=[true,false,true,false,true];
    List<dynamic> City=["Karachi","Islamabad","Lahore","Peshawar"];
    

    print(names[0]);
    print(names[1]);
    print(names[2]);
    print(ages);
    print(isStudent);
    print(City);

    names.add("Qasim");
    print(names);

    City.addAll(["US","Hyderabad","Gujrat"]);
    print(City);

    City.remove("Karachi");
    print(City);

    City.removeAt(0);
    print(City);

    for(var age in ages){
      print(age);
    }
    Map<String, int> AgesOfStudent={
      "Ali":9,
      "Zubair":11,
      "Ahmad":12,
      "Awais": 10,
      "Omar": 22
    };

    Map<String, int> PhoneModels={
      "iPhone 6":10000,
      "Samsung s8":15000,
      "HTC Vibe":5000,
      "Redmi note 5":8500
    };
    print(AgesOfStudent);
    print(AgesOfStudent["Ahmad"]);
    print(AgesOfStudent["Awais"]);
    print(PhoneModels);
    PhoneModels["Google Pixel"]=13000;
    print(PhoneModels);
    PhoneModels.addAll({"Nokia Lumia":12000,"Nexus 5x":4500,"Huawei mate 10":5500});
    print(PhoneModels);

    PhoneModels.remove("iPhone 6");
    print(PhoneModels);

    for(var phone in PhoneModels.entries){
      print("${phone.key} ${phone.value}");
    }
}