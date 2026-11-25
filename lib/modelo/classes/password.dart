import 'dart:convert';

class Password {
  String? senha;

  Password({required this.senha});

  Map<String, dynamic> toMap() {
    return {'senha': senha};
  }

  factory Password.fromMap(Map<String, dynamic> map) {
    return Password(senha: map['senha']);
  }

  static String encode(List<Password> password) => json.encode(
    password.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  static List<Password> decode(String passwordsJson) =>
      (json.decode(passwordsJson) as List<dynamic>)
          .map<Password>((item) => Password.fromMap(item))
          .toList();
}
