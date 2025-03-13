import '../models/vehicle.dart';

class VehicleRepository {
  List<Vehicle> vehicles = [];

  void add(Vehicle v) => vehicles.add(v);
  List<Vehicle> getAll() => vehicles;

  List<Vehicle> findByOwner(String personalNumber) {
    return vehicles
        .where((v) => v.owner.personalNumber == personalNumber)
        .toList();
  }
}
