import 'dart:convert';

class Agendamento {
  final int id;
  final DateTime dia;
  final int servicoID;
  final int clienteID;
  final int? desconto;

  Agendamento({
    required this.id,
    required this.dia,
    required this.servicoID,
    required this.clienteID,
    required this.desconto,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dia': dia,
      'servicoID': servicoID,
      'clienteID': clienteID,
      'desconto': desconto,
    };
  }

  factory Agendamento.fromMap(Map<String, dynamic> map) {
    return Agendamento(
      id: map['id'] ?? 0,
      dia: map['dia'] ?? DateTime.now(),
      servicoID: map['servicoID'],
      clienteID: map['clienteID'] ?? 0,
      desconto: map['desconto'] ?? 0,
    );
  }

  static String encode(List<Agendamento> agendamento) => json.encode(
    agendamento.map<Map<String, dynamic>>((p) => p.toMap()).toList(),
  );

  static List<Agendamento> decode(String agedamentoJson) =>
      (json.decode(agedamentoJson) as List<dynamic>)
          .map<Agendamento>((item) => Agendamento.fromMap(item))
          .toList();
}
