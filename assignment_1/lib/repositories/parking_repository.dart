import '../models/parking.dart';

class ParkingRepository {
  List<Parking> parkings = [];

  void add(Parking p) => parkings.add(p);
  List<Parking> getAll() => parkings;
}
