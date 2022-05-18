void main() {
  final Student s1 = Student.contact("phone numer", "email");
}

class Student {
  String? name;
  int? id;
  String? department;
  List<String>? courseName;
  String? phone;
  String? email;

  //named constructo = if dont need all property of class then we can split 
  //what we need with named contructor.
  Student.contact(this.phone, this.email);
  Student.identity(this.name, this.id); 

  //like in flutter we have Image.asset(""), Image.networ("") all are named constructor. 
}
