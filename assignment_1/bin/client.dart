import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const String apiUrl = 'http://localhost:8080';

void main() async {
  while (true) {
    print("\n🚗 Välkommen till Parkeringsappen! 🚗");
    print("1. Hantera personer");
    print("2. Hantera fordon");
    print("3. Hantera parkeringsplatser");
    print("4. Hantera parkeringar");
    print("5. Avsluta");
    stdout.write("Välj ett alternativ (1-5): ");

    String? choice = stdin.readLineSync();
    if (choice == "1") {
      await managePersons();
    } else if (choice == "2") {
      await manageVehicles();
    } else if (choice == "3") {
      await manageParkingSpaces();
    } else if (choice == "4") {
      await manageParkings();
    } else if (choice == "5") {
      print("👋 Avslutar programmet...");
      break;
    } else {
      print("⚠️ Ogiltigt val, försök igen.");
    }
  }
}

// 🔹 Hantera personer
Future<void> managePersons() async {
  print("\n1. Lägg till person");
  print("2. Visa alla personer");
  print("3. Uppdatera person");
  print("4. Ta bort person");
  stdout.write("Välj: ");
  String? choice = stdin.readLineSync();

  if (choice == "1") {
    stdout.write("Ange namn: ");
    String? name = stdin.readLineSync();
    stdout.write("Ange personnummer: ");
    String? personalNumber = stdin.readLineSync();

    if (name != null && personalNumber != null) {
      await http.post(
        Uri.parse('$apiUrl/persons'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'personalNumber': personalNumber}),
      );
      print("✅ Person tillagd!");
    }
  } else if (choice == "2") {
    var response = await http.get(Uri.parse('$apiUrl/persons'));
    print(response.body);
  } else if (choice == "3") {
    stdout.write("Ange personnummer att uppdatera: ");
    String? id = stdin.readLineSync();
    stdout.write("Ange nytt namn: ");
    String? newName = stdin.readLineSync();

    if (id != null && newName != null) {
      await http.put(
        Uri.parse('$apiUrl/persons/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': newName}),
      );
      print("✅ Person uppdaterad!");
    }
  } else if (choice == "4") {
    stdout.write("Ange personnummer att ta bort: ");
    String? id = stdin.readLineSync();

    if (id != null) {
      await http.delete(Uri.parse('$apiUrl/persons/$id'));
      print("🗑️ Person borttagen!");
    }
  }
}

// 🔹 Hantera fordon
Future<void> manageVehicles() async {
  print("\n1. Lägg till fordon");
  print("2. Visa alla fordon");
  print("3. Uppdatera fordon");
  print("4. Ta bort fordon");
  stdout.write("Välj: ");
  String? choice = stdin.readLineSync();

  if (choice == "1") {
    stdout.write("Ange registreringsnummer: ");
    String? regNum = stdin.readLineSync();
    stdout.write("Ange typ (bil, mc, etc.): ");
    String? type = stdin.readLineSync();
    stdout.write("Ange personnummer på ägaren: ");
    String? ownerId = stdin.readLineSync();

    if (regNum != null && type != null && ownerId != null) {
      await http.post(
        Uri.parse('$apiUrl/vehicles'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {'registrationNumber': regNum, 'type': type, 'owner': ownerId}),
      );
      print("✅ Fordon tillagt!");
    }
  } else if (choice == "2") {
    var response = await http.get(Uri.parse('$apiUrl/vehicles'));
    print(response.body);
  } else if (choice == "3") {
    stdout.write("Ange registreringsnummer att uppdatera: ");
    String? id = stdin.readLineSync();
    stdout.write("Ange ny typ: ");
    String? newType = stdin.readLineSync();

    if (id != null && newType != null) {
      await http.put(
        Uri.parse('$apiUrl/vehicles/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'type': newType}),
      );
      print("✅ Fordon uppdaterat!");
    }
  } else if (choice == "4") {
    stdout.write("Ange registreringsnummer att ta bort: ");
    String? id = stdin.readLineSync();

    if (id != null) {
      await http.delete(Uri.parse('$apiUrl/vehicles/$id'));
      print("🗑️ Fordon borttaget!");
    }
  }
}

// 🔹 Hantera parkeringsplatser
Future<void> manageParkingSpaces() async {
  print("\n1. Lägg till parkeringsplats");
  print("2. Visa alla parkeringsplatser");
  print("3. Ta bort parkeringsplats");
  stdout.write("Välj: ");
  String? choice = stdin.readLineSync();

  if (choice == "1") {
    stdout.write("Ange ID: ");
    String? id = stdin.readLineSync();
    stdout.write("Ange adress: ");
    String? address = stdin.readLineSync();
    stdout.write("Ange pris per timme: ");
    String? price = stdin.readLineSync();

    if (id != null && address != null && price != null) {
      await http.post(
        Uri.parse('$apiUrl/parkingspaces'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'address': address, 'pricePerHour': price}),
      );
      print("✅ Parkeringsplats tillagd!");
    }
  } else if (choice == "2") {
    var response = await http.get(Uri.parse('$apiUrl/parkingspaces'));
    print(response.body);
  } else if (choice == "3") {
    stdout.write("Ange ID på parkeringsplats att ta bort: ");
    String? id = stdin.readLineSync();

    if (id != null) {
      await http.delete(Uri.parse('$apiUrl/parkingspaces/$id'));
      print("🗑️ Parkeringsplats borttagen!");
    }
  }
}

// 🔹 Hantera parkeringar
Future<void> manageParkings() async {
  print("\n1. Starta ny parkering");
  print("2. Visa alla parkeringar");
  print("3. Ta bort parkering");
  stdout.write("Välj: ");
  String? choice = stdin.readLineSync();

  if (choice == "1") {
    stdout.write("Ange fordonets registreringsnummer: ");
    String? regNum = stdin.readLineSync();
    stdout.write("Ange parkeringsplatsens ID: ");
    String? spaceId = stdin.readLineSync();

    if (regNum != null && spaceId != null) {
      await http.post(
        Uri.parse('$apiUrl/parkings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'vehicle': regNum,
          'space': spaceId,
          'startTime': DateTime.now().toIso8601String()
        }),
      );
      print("✅ Parkering startad!");
    }
  } else if (choice == "2") {
    var response = await http.get(Uri.parse('$apiUrl/parkings'));
    print(response.body);
  } else if (choice == "3") {
    stdout.write("Ange ID på parkering att ta bort: ");
    String? id = stdin.readLineSync();

    if (id != null) {
      await http.delete(Uri.parse('$apiUrl/parkings/$id'));
      print("🗑️ Parkering borttagen!");
    }
  }
}
