import 'dart:convert';

class Servico {
  final int id;
  final String nome;
  final String? descricao;
  final int preco;

  Servico({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'descricao': descricao, 'preco': preco};
  }

  factory Servico.fromMap(Map<String, dynamic> map) {
    return Servico(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      descricao: map['descricao'],
      preco: map['preco'] ?? 0,
    );
  }

  static String encode(List<Servico> servicos) => json.encode(
    servicos.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  static List<Servico> decode(String servicosJson) =>
      (json.decode(servicosJson) as List<dynamic>)
          .map<Servico>((item) => Servico.fromMap(item))
          .toList();
}
