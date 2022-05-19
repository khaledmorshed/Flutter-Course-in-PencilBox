
void main() {
  final ElectricCar ec = ElectricCar();
  final GasCar gs = GasCar();
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
}

//but if we use mixin instead of implements then method override dont necessary.
class GasCar extends Car with Aircondition{
  int gasCapacity = 1000;
  void loadGas() => print("Loading a gas car");
  // @override
  // void powerOn() {
  //   print("Turning on AC from gas car");
  // }
}

class Aircondition {

  void powerOn(){
    print("Turning on AC");
  }
} 

