import 'dart:convert';

class Cliente {
  final int id;
  final String nome;
  final String? descricao;

  Cliente({required this.id, required this.nome, required this.descricao});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'descricao': descricao};
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      descricao: map['descricao'],
    );
  }

  static String encode(List<Cliente> cliente) =>
      json.encode(cliente.map<Map<String, dynamic>>((p) => p.toMap()).toList());

  static List<Cliente> decode(String clienteJson) =>
      (json.decode(clienteJson) as List<dynamic>)
          .map<Cliente>((item) => Cliente.fromMap(item))
          .toList();
}
