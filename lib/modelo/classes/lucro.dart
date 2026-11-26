import 'dart:convert';

class Lucro {
  final int id;
  final String nome;
  final String? descricao;
  final int preco;
  final int saldoID;

  Lucro({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.saldoID,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'saldoID': saldoID,
    };
  }

  factory Lucro.fromMap(Map<String, dynamic> map) {
    return Lucro(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      descricao: map['descricao'],
      preco: map['preco'] ?? 0,
      saldoID: map['saldoID'] ?? 0,
    );
  }

  static String encode(List<Lucro> lucro) =>
      json.encode(lucro.map<Map<String, dynamic>>((p) => p.toMap()).toList());

  static List<Lucro> decode(String lucroJson) =>
      (json.decode(lucroJson) as List<dynamic>)
          .map<Lucro>((item) => Lucro.fromMap(item))
          .toList();
}
