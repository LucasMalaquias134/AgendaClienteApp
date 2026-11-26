import 'dart:convert';

class Saldo {
  final int id;
  final DateTime dia;
  final int saldo;

  Saldo({required this.id, required this.dia, required this.saldo});

  Map<String, dynamic> toMap() {
    return {'id': id, 'dia': dia, 'saldo': saldo};
  }

  factory Saldo.fromMap(Map<String, dynamic> map) {
    return Saldo(
      id: map['id'] ?? 0,
      dia: map['dia'] ?? DateTime.now(),
      saldo: map['saldo'] ?? 0,
    );
  }

  static String encode(List<Saldo> saldo) =>
      json.encode(saldo.map<Map<String, dynamic>>((p) => p.toMap()).toList());

  static List<Saldo> decode(String saldoJson) =>
      (json.decode(saldoJson) as List<dynamic>)
          .map<Saldo>((item) => Saldo.fromMap(item))
          .toList();
}
