class User {
  final String name;
  final String username;
  final String password;

  User({
    required this.name,
    required this.username,
    required this.password
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'username': username,
    'password': password,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json['name'],
    username: json['username'],
    password: json['password'],
  );
}