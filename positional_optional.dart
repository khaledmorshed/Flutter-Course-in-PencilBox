void main() {
  add();
  subtract(5);
}

//this positional optional function. here two parameter are optional
void add([int a = 0, int b = 0]) => a + b;
//this also positional optional function but here one parameter is optional and one is mnadatory
///here postion is factor. we can not ignore its position. we have to pass arument with position
void subtract(int a, [int b = 0]) => a + b;