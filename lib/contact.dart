class Contact {
  final String name;
  final String phoneNumber;
  final String email;

  Contact({required this.name, required this.phoneNumber, required this.email});

  toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }

  static fromJson(jsonData) {
    return Contact(
        name: jsonData['name'],
        phoneNumber: jsonData['phoneNumber'],
        email: jsonData['email']);
  }
}
