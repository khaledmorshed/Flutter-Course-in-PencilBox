void main() {
  //constructor = when a object(s1) of class is created then it calls conttructor
  //of that class
  //constructor assign the value inside of all properties of that class
  final Student s1 = Student() /*this is a constructor*/;
  print(s1.name);
  s1.name = "morshed";
  print(s1.name);
  s1.name = null;
  //if s1.name == null, then ? = s1.name? won't call the ".length" function
  //and program will not crash
  print(s1.name?.length);
  //if s1.name == null, then ! = s1.name! will call ".length" and program
  //will crash. Because ! operator assure the compiler that s1.name is not null and
  //compiler will not give error
  // but s1.name is actually null.So during run time it throw error like(
  // cannot read properties of null)
  print(s1.name!.length);

  //so ? is safe. because if value null then it handle
  //but some time ? it will not work if value null like Text widget
  //Text(s1.name?) == it will not work beacuse Text widget can not allow to assign
  //null value. so in Text(s1.name!) it will work because it garuntee that s1.name is not null

  //if else short cut is ??
  //here if s1.name == null then print "undefined" otherwise value of s1.name
  print(s1.name ?? "undefined");
}

//a class is a blue print of obecjt. we all things are object(like: man, bus, house)
class Student {
  String? name;
  int? id;
}
