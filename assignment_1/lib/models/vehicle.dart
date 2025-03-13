import 'person.dart';

class Vehicle {
  String registrationNumber;
  String type;
  Person owner;

  Vehicle(this.registrationNumber, this.type, this.owner);

  @override
  String toString() {
    return '[$type] $registrationNumber - Ägare: ${owner.name}';
  }
}
