void main() {
  final Student s1 = Student();
  s1.name = "morshed";
  s1.id = 10315;
  s1.phone = "017";

  //instead of s1.name, s1.id we can follow bellow method with cascade notaion(..)
  //method 1
  final Student s2 = Student()
  ..name = "sany"
  ..id = 1035
  ..phone = "01530";

  //method 2
  final Student s3 = Student();
  s3..name = "noyon"
  ..id = 10310
  ..phone = "015";
}

class Student {
  String? name;
  int? id;
  String? department;
  List<String>? courseName;
  String? phone;
  String? email;
}
