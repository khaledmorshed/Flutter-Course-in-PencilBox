void main() {
  final countries = ["Australia", "Bangladesh", "Canda"];

  //forEach takes a String typed function with void return type
  //like here element is String type variable
  //forEach actually run a internal for loop. like first it takes Australia and pass it to
  //lambda funtion then lambda funtion return its result
  countries.forEach((/*String*/ element) {
    print(element.toLowerCase());
  });

  //here we can also pass another function inside fo forEach loop like before
  countries.forEach(printElement);
}

printElement(String element) => print(element.toUpperCase());
