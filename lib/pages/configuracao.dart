import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/drawergeral.dart';
import 'package:flutter/material.dart';

class Configuracao extends StatefulWidget {
  const new({super.key});

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 23, 76),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: ListView(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: AlignmentGeometry.center,
                children: [
                  Column(
                    children: [
                      Container(height: 75),
                      Container(height: 200, color: Colors.amber),
                    ],
                  ),
                  Positioned(
                    top: 15,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xFF1B1437),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 200, color: Colors.blue),
              Container(height: 200, color: Colors.green),
              Container(height: 200, color: Colors.red),
            ],
          ),
        ),
      ),
      drawer: Drawergeral(),
      appBar: Appbargeral(),
    );
  }
}
