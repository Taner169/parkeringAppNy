import 'vehicle.dart';
import 'parking_space.dart';

class Parking {
  Vehicle vehicle;
  ParkingSpace space;
  DateTime startTime;
  DateTime? endTime;

  Parking(this.vehicle, this.space, this.startTime, [this.endTime]);

  double calculateCost() {
    if (endTime == null) {
      return 0.0; // Pågående parkering har ingen kostnad än
    }
    Duration duration = endTime!.difference(startTime);
    return (duration.inHours + 1) * space.pricePerHour;
  }

  @override
  String toString() {
    String status = endTime == null ? "Pågående" : "Avslutad";
    return '🚗 Parkering: Fordon ${vehicle.registrationNumber} på plats ${space.address} (${status})';
  }
}
