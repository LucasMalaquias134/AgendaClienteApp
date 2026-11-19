import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/drawergeral.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const new({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 23, 76),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: ListView(
            children: [
              Container(height: 200, color: Colors.lightBlue),
              Container(height: 200, color: Colors.amber),
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
