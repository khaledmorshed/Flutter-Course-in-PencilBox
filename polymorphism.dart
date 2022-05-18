void main() {
  final ElectricCar ec = ElectricCar();
  final GasCar gc = GasCar();

  //polymorphism(bohurupita) = when we call a common method
  //(which method(from parent class) is overrided in every child class) with
  //object of parent class
  //here drive method is done override from ElectricCar and GasCar.so if we call
  //dive method with object of Car then it will behave different for every child class

  //carList is parent type object but inside of this we put chlid type object
  final List<Car> carList = [ec, gc];
  carList.forEach((car) {
    //car parent ta ak ak somoy ak ak child er object er moto behave korce
    //etai polymorphism behavior
    //it not calling drive method of parent classs.
    //it is calling as like as ec.drive() and gc.drive()
    car.drive();
  });
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
