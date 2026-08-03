void main(){
    print("For loop");
    for(int i=0; i<5; i++){
    print(i);
    }

    int i=0;
    print("\nWhile loop");
    while(i<5){
      print(i);
      i++;
    }

    i=0;
    print("\nDo while loop");
    do{
      print(i);
      i++;
    }while(i<5);


    List<String> fruits=["apple","banana","orange","mango","lychee"];
    print("\nFor in loop ");
    for(var i in fruits){
      print(i);
    }
    print("");
    List<int> ages=[1,2,3,4,5,6,7,8,9,10];
    for(var i in ages){
      print(i);
    }

    print("");
    print("Break: ");
    for(int i=0;i<10;i++){
      if(i==7){
        break;
      }
      print(i);
    }
    print("");
    print("Continue: ");
    for(int j=0;j<10;j++){
      if(j==8){
        continue;
      }
      print(j);
    }
    print("");
    print("Even numbers: ");
    for(int i=0;i<20;i++){
      if(i%2!=0){
        continue;
      }
      print(i);
    }
    print("");
    print("Odd numbers: ");
    for(int i=0;i<20;i++){
      if(i%2==0){
        continue;
      }
      print(i);
    }
}
