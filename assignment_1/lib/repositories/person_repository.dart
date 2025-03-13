import '../models/person.dart';

class PersonRepository {
  List<Person> people = [];

  void add(Person p) => people.add(p);
  List<Person> getAll() => people;
}
