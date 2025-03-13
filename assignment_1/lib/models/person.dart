class Person {
  String name;
  String personalNumber;

  Person(this.name, this.personalNumber);

  @override
  String toString() {
    return '$name ($personalNumber)';
  }
}
