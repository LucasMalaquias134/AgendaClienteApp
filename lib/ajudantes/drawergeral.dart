import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:agendacliente/pages/clientesPage.dart';
import 'package:agendacliente/pages/configuracao.dart';
import 'package:agendacliente/pages/home.dart';
import 'package:agendacliente/pages/saldoPage.dart';
import 'package:agendacliente/pages/servicosPage.dart';
import 'package:flutter/material.dart';

class Drawergeral extends StatefulWidget {
  const new({super.key});

  @override
  State<Drawergeral> createState() => _DrawergeralState();
}

class _DrawergeralState extends State<Drawergeral> {
  @override
  Widget build(BuildContext context) {
    Map<String, Color> cores = corAjuda.getMetod(PrefsService.instance.cor);
    return Drawer(
      backgroundColor: cores['corDeFundoPrincipal'],
      child: ListView(
        children: [
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'AgendaCli',
                style: TextStyle(color: cores['corDeBotao'], fontSize: 30),
              ),
            ],
          ),
          SizedBox(height: 25),
          ajudaRapida(
            titulo: Text(
              'Sua Agenda',
              style: TextStyle(color: cores['corDeTexto']),
            ),
            widgeta: Home(),
            icone: Icon(Icons.calendar_month, color: cores['corDeTexto']),
          ),
          SizedBox(height: 25),
          ajudaRapida(
            titulo: Text(
              'Seus Clientes',
              style: TextStyle(color: cores['corDeTexto']),
            ),
            widgeta: Clientespage(),
            icone: Icon(Icons.person, color: cores['corDeTexto']),
          ),
          SizedBox(height: 25),
          ajudaRapida(
            titulo: Text(
              'Seus serviços',
              style: TextStyle(color: cores['corDeTexto']),
            ),
            widgeta: Servicospage(),
            icone: Icon(Icons.format_list_bulleted, color: cores['corDeTexto']),
          ),
          SizedBox(height: 25),
          ajudaRapida(
            titulo: Text(
              'Evolução do saldo',
              style: TextStyle(color: cores['corDeTexto']),
            ),
            widgeta: Saldopage(),
            icone: Icon(Icons.show_chart, color: cores['corDeTexto']),
          ),
          SizedBox(height: 25),
          ajudaRapida(
            titulo: Text(
              'Configurações',
              style: TextStyle(color: cores['corDeTexto']),
            ),
            widgeta: Configuracao(),
            icone: Icon(Icons.settings, color: cores['corDeTexto']),
          ),
        ],
      ),
    );
  }
}

class ajudaRapida extends StatelessWidget {
  final Widget titulo;
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
      title: titulo,
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => widgeta),
        );
      },
    );
  }
}
