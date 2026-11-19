import 'dart:convert';

class User {
  String? name;
  String? email;
  String? urlImage;
  int cor;

  User({
    this.name = 'Usuáriosss',
    this.email,
    this.urlImage,
    required this.cor,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'urlImage': urlImage, 'cor': cor};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? 'Usuário',
      email: map['email'] ?? '',
      urlImage: map['urlImage'] ?? '',
      cor: map['cor'] ?? 0,
    );
  }

  static String encode(List<User> usuarios) => json.encode(
    usuarios.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  static List<User> decode(String usersJson) =>
      (json.decode(usersJson) as List<dynamic>)
          .map<User>((item) => User.fromMap(item))
          .toList();
}
