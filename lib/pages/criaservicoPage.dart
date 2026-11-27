import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/controle/servicosController.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:agendacliente/pages/servicosPage.dart';
import 'package:flutter/material.dart';

class Criaservicopage extends StatefulWidget {
  const new({super.key});

  @override
  State<Criaservicopage> createState() => _CriaservicopageState();
}

class _CriaservicopageState extends State<Criaservicopage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController precocontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void enviar() async {
    if (formKey.currentState!.validate()) {
      bool resultado = await Servicoscontroller.criarServico(
        namecontroller.text,
        desccontroller.text,
        double.parse(precocontroller.text),
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
          MaterialPageRoute(builder: (context) => Servicospage()),
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
    precocontroller.dispose();
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
                        placeHolder: 'Nome do Serviço',
                        labelFlutante: true,
                        placeHolder2: '',
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
                        placeHolder: 'Preço do Serviço',
                        labelFlutante: true,
                        placeHolder2: '',
                        numerico: true,
                        controller: precocontroller,
                        validador: (p0) {
                          if (p0 == null || p0.trim().isEmpty) {
                            return 'Preencha esse campo!';
                          }
                          if (double.parse(p0) < 0) {
                            return 'Não pode valores negativos!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      Textfieldajudante(
                        temaEscuro: (PrefsService.instance.cor == 1)
                            ? false
                            : true,
                        placeHolder: 'Descrição do Serviço (opcional)',
                        labelFlutante: true,
                        placeHolder2: '',
                        controller: desccontroller,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cores['corDeBotao'],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: enviar,
                        child: Text('Cadastrar novo Serviço'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: Appbargeral(titulo: 'Cadastrar novo Serviço', leading: true),
    );
  }
}
