void main() {
  final ElectricCar ec = ElectricCar();
  final GasCar gs = GasCar();
  ec.drive();
  gs.drive();
}

class Car {
  String? name;
  String? color;
  void drive() {
    print("Driving a car");
  }
}

class ElectricCar extends Car {
  int chargeCapacity = 100;
  void charge() {
    print("charnging a electric car");
  }

  @override
  void drive() {
    print("Driving electric car");
  }
}

class GasCar extends Car {
  int gasCapacity = 1000;
  void loadGas() => print("Loading a gas car");
  //here we have drive method overirde from Car class.
  //and we can change as we want. And if this drive method will be called,
  //then it will call from here not to call from paren class(Car)
  @override
  void drive() {
    print("Driving gas car");
  }
}
