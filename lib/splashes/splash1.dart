import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/controle/passwordcontroller.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:agendacliente/pages/home.dart';
import 'package:agendacliente/pages/passwordPage.dart';
import 'package:flutter/material.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() {
    super.initState();
    espera();
  }

  Future<void> espera() async {
    bool resultado = await esperaPrincipal();
    await PrefsService.instance.init();

    if (resultado) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Passwordpage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  Future<bool> esperaPrincipal() async {
    return await Passwordcontroller.verSessao();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Color> cores = corAjuda.getMetod(PrefsService.instance.cor);
    return Scaffold(
      backgroundColor: cores['corDeFundoPrincipal'],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(50),
              child: LinearProgressIndicator(
                color: cores['corDeBotao'],
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
