class User {
  late int id;
  late String name;
  late String username;
  late String email;
  late Address address;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] ?? 0, // Provide a default value for int type
      name: json["name"] ?? '',
      username: json["username"] ?? '',
      email: json["email"] ?? '',
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  late String street;
  late String suite;
  late String city;
  late String zipcode;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      suite: json['suite'] ?? '',
      city: json['city'] ?? '',
      zipcode: json['zipcode'] ?? '',
    );
  }
}
