void main() {
  final ElectricCar ec = ElectricCar();

  //it is possible. Because inside of GasCar{} name, color and method drive() are
  //present and any child class has ability to intialize a parent class
  final Car car = GasCar();
  //poisble
  car.drive();
  //not possible
  car.loadGas();

  //it is not possible. Becasue inside of Car{} gasCapacity, loadGas() are not present.
  final GasCar gs = Car();

}

class Car {
  String? name;
  String? color;
  void drive() {
    print("Driving a car");
  }
}

//inheritance actually it prevents the code duplication. like name and color will get
//all type of car.so it will be bad if we agin declare name and color in all class
//inheritance = is-a relation (like: ElectricCar is a car)
class ElectricCar extends Car {
  int chargeCapacity = 100;
  void charge() {
    print("charnging a electric car");
  }
}

//we can not extend multiple class from single child class
class GasCar extends Car {
  int gasCapacity = 1000;
  void loadGas() => print("Loading a gas car");
}
