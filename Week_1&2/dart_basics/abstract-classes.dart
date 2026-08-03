abstract class Number{
  void calculateEvenOdd();
}
class Calculate extends Number{
  int num;

  Calculate(this.num);
  void calculateEvenOdd(){
    if(num%2==0){
      print("number ${num} is even.");
    }
    else{
      print("number ${num} is odd.");
    }
  }
}
void main(){
  Calculate C=Calculate(100);
  C.calculateEvenOdd();
}