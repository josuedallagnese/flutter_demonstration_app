class Customer {
  final int id;
  final String name;
  final String email;
  final String avatar;

  Customer({
    required this.id, 
    required this.name,
    required this.email,
    required this.avatar});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'avatar': avatar};
  }

  @override
  String toString() {
    return 'Customer{id: $id, name: $name, email: $email, avatar: $avatar}';
  }
}
