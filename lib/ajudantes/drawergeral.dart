import 'package:agendacliente/pages/configuracao.dart';
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
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Configuracao()),
              );
            },
          ),
        ],
      ),
    );
  }
}
