import "dart:io";

void main(){
  print("Nested for: ");
  for(int i=0;i<5;i++){
    for(int j=0;j<5;j++){
      stdout.write("*");
    }
    print("");
  }
  
  print("Nested while:");
  int i=0,j;
  while(i<5){
    j=0;
    while(j<5){
      stdout.write("*");
      j++;
    }
    print("");
    i++;
  }

  print("Nested do while: ");
  i=0;
  do{
    j=0;
    do{
      stdout.write("*");
      j++;
    }while(j<5);
    print("");
    i++;
  }while(i<5);
}