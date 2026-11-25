import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/controle/passwordcontroller.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:agendacliente/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Passwordpage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordcontroller = TextEditingController();

    final formKey = GlobalKey<FormState>();

    void enviar2() async {
      if (formKey.currentState!.validate()) {
        bool resultado = await Passwordcontroller.comparaSenha(
          passwordcontroller.text,
        );
        if (resultado) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sucesso!'), backgroundColor: Colors.green),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Senha incorreta!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Algo deu errado, tente novamente'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    Map<String, Color> cores = corAjuda.getMetod(PrefsService.instance.cor);
    return Scaffold(
      backgroundColor: cores['corDeFundoPrincipal'],
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: cores['corDeFundo2'],
              borderRadius: BorderRadius.circular(24),
            ),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          Icons.lock,
                          color: cores['corDeTexto'],
                          size: 30,
                        ),
                        title: Text(
                          "Insira sua Senha",
                          style: TextStyle(
                            color: cores['corDeTexto'],
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Textfieldajudante(
                        temaEscuro: (PrefsService.instance.cor == 1)
                            ? false
                            : true,
                        placeHolder: 'Senha',
                        eSenha: true,
                        controller: passwordcontroller,
                        validador: (p0) {
                          if (p0 == null || p0.trim().isEmpty) {
                            return 'É necessário preencher esse campo!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cores['corDeBotao'],
                          foregroundColor: Colors.white,
                        ),
                        onPressed: enviar2,
                        child: Text('Salvar Senha'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
