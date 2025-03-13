import '../models/parking_space.dart';

class ParkingSpaceRepository {
  List<ParkingSpace> spaces = [];

  void add(ParkingSpace ps) => spaces.add(ps);
  List<ParkingSpace> getAll() => spaces;
}
