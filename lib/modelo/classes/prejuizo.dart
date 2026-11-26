import 'dart:convert';

class Prejuizo {
  final int id;
  final String nome;
  final String? descricao;
  final int preco;
  final int saldoID;

  Prejuizo({
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

  factory Prejuizo.fromMap(Map<String, dynamic> map) {
    return Prejuizo(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      descricao: map['descricao'],
      preco: map['preco'] ?? 0,
      saldoID: map['saldoID'] ?? 0,
    );
  }

  static String encode(List<Prejuizo> prejuizo) => json.encode(
    prejuizo.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  static List<Prejuizo> decode(String prejuizoJson) =>
      (json.decode(prejuizoJson) as List<dynamic>)
          .map<Prejuizo>((item) => Prejuizo.fromMap(item))
          .toList();
}
