void main() {
  //way 1 = must be given student name and id can be optional
  final Student s1 = Student("Morshed");

  //way 2 = must be given student name and id can be optional
  final Student2 s2 = Student2(name2: "morshsed");
}

class Student {
  String name;
  int id;
  //way 1
  //here name is mandatory id is optinal
  Student(this.name, {this.id = 0});
}

class Student2{
  String name2;
  int id2;
  //way 2
  //here also name is madatory though {} is used.
  //because in front of this.namw2 required is assigned
  Student2({required this.name2, this.id2 = 0});
}