import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/ajudantes/drawergeral.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:flutter/material.dart';

class Saldopage extends StatefulWidget {
  const new({super.key});

  @override
  State<Saldopage> createState() => _SaldopageState();
}

class _SaldopageState extends State<Saldopage> {
  @override
  Widget build(BuildContext context) {
    Map<String, Color> cores = corAjuda.getMetod(PrefsService.instance.cor);
    return Scaffold(
      backgroundColor: cores['corDeFundoPrincipal'],
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: ListView(children: [
              
            ],
          ),
      ),
      drawer: Drawergeral(),
      appBar: Appbargeral(titulo: 'Evolução do saldo'),
    );
  }
}
