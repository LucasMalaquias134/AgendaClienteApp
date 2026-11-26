import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/controle/clientesController.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:agendacliente/pages/clientesPage.dart';
import 'package:flutter/material.dart';

class Criaclientepage extends StatefulWidget {
  const new({super.key});

  @override
  State<Criaclientepage> createState() => _CriaclientepageState();
}

class _CriaclientepageState extends State<Criaclientepage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void enviar() async {
    if (formKey.currentState!.validate()) {
      bool resultado = await Clientescontroller.criarCliente(
        namecontroller.text,
        desccontroller.text,
      );

      if (resultado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Salvo Com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Clientespage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Algo de Errado, tente de novo'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    namecontroller.dispose();
    desccontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Color> cores = corAjuda.getMetod(PrefsService.instance.cor);
    return Scaffold(
      backgroundColor: cores['corDeFundoPrincipal'],
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: cores['corDeFundo2'],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Textfieldajudante(
                        temaEscuro: (PrefsService.instance.cor == 1)
                            ? false
                            : true,
                        placeHolder: 'Nome do Cliente',
                        labelFlutante: true,
                        placeHolder2: 'Ex: Joana...',
                        controller: namecontroller,
                        validador: (p0) {
                          if (p0 == null || p0.trim().isEmpty) {
                            return 'Preencha esse campo!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Textfieldajudante(
                        temaEscuro: (PrefsService.instance.cor == 1)
                            ? false
                            : true,
                        placeHolder: 'Descrição do Cliente (opcional)',
                        labelFlutante: true,
                        placeHolder2: 'Ex: Loira...',
                        controller: desccontroller,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cores['corDeBotao'],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: enviar,
                        child: Text('Cadastrar novo Cliente'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: Appbargeral(titulo: 'Cadastrar novo Cliente', leading: true),
    );
  }
}
