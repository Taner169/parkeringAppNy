import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

final List<Map<String, String>> persons = [];
final List<Map<String, String>> vehicles = [];
final List<Map<String, String>> parkingSpaces = [];
final List<Map<String, String>> parkings = [];

void main() async {
  final router = Router();

  // **Huvudmeny**
  router.get(
      '/',
      (Request request) => Response.ok(_buildHomePage(),
          headers: {'Content-Type': 'text/html'}));

  // **Hantera Personer**
  router.get(
      '/persons',
      (Request request) => Response.ok(
          _buildPage('👤 Hantera personer', persons, 'name', 'personalNumber',
              'persons'),
          headers: {'Content-Type': 'text/html'}));

  router.post('/persons/add', (Request request) async {
    return _addEntity(request, persons, 'name', 'personalNumber', '/persons');
  });

  router.post('/persons/delete', (Request request) async {
    return _deleteEntity(request, persons, 'personalNumber', '/persons');
  });

  // **Hantera Fordon**
  router.get(
      '/vehicles',
      (Request request) => Response.ok(
          _buildPage('🚗 Hantera fordon', vehicles, 'registrationNumber',
              'type', 'vehicles'),
          headers: {'Content-Type': 'text/html'}));

  router.post('/vehicles/add', (Request request) async {
    return _addEntity(
        request, vehicles, 'registrationNumber', 'type', '/vehicles');
  });

  router.post('/vehicles/delete', (Request request) async {
    return _deleteEntity(request, vehicles, 'registrationNumber', '/vehicles');
  });

  // **Hantera Parkeringsplatser**
  router.get(
      '/parkingspaces',
      (Request request) => Response.ok(
          _buildPage('🅿️ Hantera parkeringsplatser', parkingSpaces, 'id',
              'address', 'parkingspaces'),
          headers: {'Content-Type': 'text/html'}));

  router.post('/parkingspaces/add', (Request request) async {
    return _addEntity(
        request, parkingSpaces, 'id', 'address', '/parkingspaces');
  });

  router.post('/parkingspaces/delete', (Request request) async {
    return _deleteEntity(request, parkingSpaces, 'id', '/parkingspaces');
  });

  // **Hantera Parkeringar**
  router.get(
      '/parkings',
      (Request request) => Response.ok(
          _buildPage('🏢 Hantera parkeringar', parkings, 'vehicle', 'space',
              'parkings'),
          headers: {'Content-Type': 'text/html'}));

  router.post('/parkings/add', (Request request) async {
    return _addEntity(request, parkings, 'vehicle', 'space', '/parkings');
  });

  router.post('/parkings/delete', (Request request) async {
    return _deleteEntity(request, parkings, 'vehicle', '/parkings');
  });

  // **Starta server**
  await io.serve(
    const Pipeline().addMiddleware(logRequests()).addHandler(router),
    'localhost',
    8080,
  );

  print('✅ Servern körs på http://localhost:8080');
}

// **Bygger Huvudsidan**
String _buildHomePage() {
  return '''
  <html>
  <head>
    <title>Parkeringssystem</title>
    <style>
      body { font-family: Arial, sans-serif; text-align: center; }
      h1 { font-size: 2rem; }
      ul { list-style-type: none; padding: 0; }
      li { margin: 10px 0; }
      a { text-decoration: none; font-size: 1.2rem; color: #333; }
    </style>
  </head>
  <body>
    <h1>🚗 Parkeringssystem</h1>
    <ul>
      <li>📋 <a href="/persons">Hantera personer</a></li>
      <li>🚙 <a href="/vehicles">Hantera fordon</a></li>
      <li>🅿️ <a href="/parkingspaces">Hantera parkeringsplatser</a></li>
      <li>🏢 <a href="/parkings">Hantera parkeringar</a></li>
    </ul>
  </body>
  </html>
  ''';
}

// **Bygger Hanteringssidor**
String _buildPage(String title, List<Map<String, String>> data, String key1,
    String key2, String endpoint) {
  return '''
  <html>
  <head>
    <title>$title</title>
    <style>
      body { font-family: Arial, sans-serif; text-align: center; }
      h1 { font-size: 2rem; }
      ul { list-style-type: none; padding: 0; }
      li { margin: 10px 0; }
      input, button { padding: 10px; margin: 5px; }
    </style>
  </head>
  <body>
    <h1>$title</h1>
    <ul>
      ${data.map((item) => '<li>${item[key1]} - ${item[key2]} <form action="/$endpoint/delete" method="post" style="display:inline;"><input type="hidden" name="$key1" value="${item[key1]}"><button type="submit">❌ Radera</button></form></li>').join('')}
    </ul>

    <form action="/$endpoint/add" method="post">
      <input type="text" name="$key1" placeholder="$key1" required>
      <input type="text" name="$key2" placeholder="$key2" required>
      <button type="submit">➕ Lägg till</button>
    </form>

    <br>
    <a href="/">⬅️ Tillbaka</a>
  </body>
  </html>
  ''';
}

// **Generisk funktion för att lägga till data**
Future<Response> _addEntity(Request request, List<Map<String, String>> list,
    String key1, String key2, String redirect) async {
  try {
    final body = await request.readAsString();
    final data = Uri.splitQueryString(body);

    if (!data.containsKey(key1) || !data.containsKey(key2)) {
      return Response(400, body: 'Invalid data');
    }

    list.add({key1: data[key1]!, key2: data[key2]!});
    return Response.found(redirect);
  } catch (e) {
    return Response.internalServerError(body: 'Error adding data: $e');
  }
}

// **Generisk funktion för att radera data**
Future<Response> _deleteEntity(Request request, List<Map<String, String>> list,
    String key, String redirect) async {
  try {
    final body = await request.readAsString();
    final data = Uri.splitQueryString(body);

    list.removeWhere((item) => item[key] == data[key]);
    return Response.found(redirect);
  } catch (e) {
    return Response.internalServerError(body: 'Error deleting data: $e');
  }
}
