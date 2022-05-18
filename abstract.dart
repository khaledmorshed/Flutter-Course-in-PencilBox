void main() {
  final ElectricCar ec = ElectricCar();
  final GasCar gc = GasCar();
  final List<Car> carList = [ec, gc];
  carList.forEach((car) {
    car.drive();
  });
}

abstract class Car {
  String? name;
  String? color;
  //it abstract method. Because {} is absent.
  //and now every child must do override drive method otherwise they will get error
  void drive();
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

//when GasCar overide drive method then ok(i)
class GasCar extends Car {
  int gasCapacity = 1000;
  void loadGas() => print("Loading a gas car");
  @override
  void drive() {
    print("Driving gas car");
  }
}

//(i)but and when GasCar declared itself abastract that means it will take any
//rensposibility to orveride drive method.(ii)
// abstract class GasCar extends Car {
//   int gasCapacity = 1000;
//   void loadGas() => print("Loading a gas car");
  
// }
// //(ii) then it son-in-law will take responisbility 
// class AnotherGasCar extends GasCar{
//   @override
//   void drive() {
//     // TODO: implement drive
//   }
// }