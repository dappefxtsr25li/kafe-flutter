class User {
  final String id; // Add id property
  final String name;
  final String email;
  final String role;
  final String imageUrl; // Add imageUrl property

  User({
    required this.id, // Update constructor
    required this.name,
    required this.email,
    required this.role,
    required this.imageUrl, // Update constructor
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'], // Parse id from JSON
      name: json['name'],
      email: json['email'],
      role: json['role'],
      imageUrl: json['imageUrl'], // Parse imageUrl from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include id in JSON
      'name': name,
      'email': email,
      'role': role,
      'imageUrl': imageUrl, // Include imageUrl in JSON
    };
  }
}
