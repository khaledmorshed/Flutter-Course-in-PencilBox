void main() {
  final Student s1 = Student() /*this is a constructor*/;
  print(s1.name);
  s1.name = "morshed";
}

class Student {
  //if we dont give ? after data type it will show wrong.
  //but if we create a constructor then it will not show error
  //because constructor assign a default value to the properties
  String name;
  int id;
  Student(this.name, this.id); //now it is ok

  //but if we do it as optional parameter. means we don't give paremeter inside
  // of constructor then its ok. like bellow then it will show wrong.
  Student({this.name, this.id}); //now it is not ok.
  // And solution
  //solution: 1, (String? name and int? id)
  //solution: 2, defalut value inside of constructor = Student({this.name = '', this.id = 0});
}
