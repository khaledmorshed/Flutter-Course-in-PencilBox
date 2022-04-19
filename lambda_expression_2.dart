void main() {
  add(5, 9, () {
    print(5 + 9);
  });
}

//(){} = this function is assigning into action. then action() call '(){}' this anonymous function
add(int a, int b, Function action) {
  action();
}
