void main() {
  //thus we can ignore argument passing
  add();
  //here position is not factor. we can pass argument as with indicate
  subtract(b: 5, a: 6);
}

//name optional. not necessay to pass argument.
void add({int a = 0, int b = 0}) => a + b;
//named optional 
void subtract({int a = 0, int b = 0}) => a + b;