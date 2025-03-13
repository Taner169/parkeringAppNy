class ParkingSpace {
  int id;
  String address;
  double pricePerHour;

  ParkingSpace(this.id, this.address, this.pricePerHour);

  @override
  String toString() {
    return 'Parkeringsplats ID: $id, Adress: $address, Pris per timme: $pricePerHour kr';
  }
}
