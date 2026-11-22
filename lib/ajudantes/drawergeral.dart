import 'package:agendacliente/pages/configuracao.dart';
import 'package:agendacliente/pages/home.dart';
import 'package:flutter/material.dart';

class Drawergeral extends StatefulWidget {
  const new({super.key});

  @override
  State<Drawergeral> createState() => _DrawergeralState();
}

class _DrawergeralState extends State<Drawergeral> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 36, 23, 76),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Cabeçalho', style: TextStyle(color: Colors.white)),
          ),
          ajudaRapida(titulo: 'Home', widgeta: Home(), icone: Icon(Icons.home)),
          ajudaRapida(
            titulo: 'Configurações',
            widgeta: Configuracao(),
            icone: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

class ajudaRapida extends StatelessWidget {
  final String titulo;
  final Widget widgeta;
  final Icon icone;
  const ajudaRapida({
    required this.titulo,
    required this.widgeta,
    required this.icone,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icone,
      title: Text(titulo),
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => widgeta),
        );
      },
    );
  }
}
