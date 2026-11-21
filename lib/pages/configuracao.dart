import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/drawergeral.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/controle/usercontroller.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:flutter/material.dart';

//enum AcaoMenu { editar, compartilhar, excluir }

class Configuracao extends StatefulWidget {
  const new({super.key});

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  String _ultimaAcao = 'Nenhuma ação selecionada';

  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    emailcontroller.dispose();
  }

  @override
  void initState() {
    super.initState();
    namecontroller.text = PrefsService.instance.usuario?.name ?? '';
    emailcontroller.text = PrefsService.instance.usuario?.email ?? '';
  }

  void enviar() async {
    if (formKey.currentState!.validate()) {
      bool resultado = await Usercontroller.salvarUser(
        namecontroller.text,
        emailcontroller.text,
      );

      if (resultado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Salvo Com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          PrefsService.instance.salvarNome(
            namecontroller.text,
            emailcontroller.text,
            null,
            null,
          );
        });
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

  Future<void> editarFoto(BuildContext context) async {
    final int? confirmado = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Foto'),
          content: Text('Deseja editar sua foto?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(1),
              child: Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(3),
              child: Text('Editar'),
            ),
          ],
        );
      },
    );

    switch (confirmado) {
      case 2:
        break;
      case 3:
        break;
    }

    if (confirmado == true) {
      // Execute a ação confirmada aqui
    }
  }

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
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton<String>(
                              iconColor: Colors.white,
                              position: PopupMenuPosition.under,
                              onSelected: (String opcao) {
                                switch (opcao) {
                                  case '1':
                                    editarFoto(context);
                                    break;
                                  case '2':
                                    break;
                                  case '3':
                                    break;
                                  default:
                                }
                              },
                              itemBuilder: (BuildContext context) => const [
                                PopupMenuItem<String>(
                                  value: '1',
                                  child: ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Editar Foto'),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: '2',
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    title: Text(
                                      'Excluir Foto',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                PopupMenuDivider(),
                                PopupMenuItem<String>(
                                  value: '3',
                                  child: ListTile(
                                    leading: Icon(Icons.color_lens),
                                    title: Text('Cores'),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 65,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 19, 13, 38),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 19, 13, 38),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(24),
                          ),
                        ),
                        //MUDA A COR AQUIIIIII

                        child: Padding(
                          padding: EdgeInsetsGeometry.all(10),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Textfieldajudante(
                                  placeHolder: 'Nome',
                                  labelFlutante: true,
                                  placeHolder2:
                                      PrefsService.instance.usuario?.name,
                                  controller: namecontroller,
                                ),
                                SizedBox(height: 20),
                                Textfieldajudante(
                                  placeHolder: 'Email',
                                  labelFlutante: true,
                                  placeHolder2:
                                      PrefsService.instance.usuario?.email,
                                  controller: emailcontroller,
                                  validador: (p0) {
                                    if (p0 == null || p0.trim().isEmpty) {
                                      return null;
                                    }
                                    final text = p0.trim();
                                    if (text.length < 3) {
                                      return 'O e-mail deve ter pelo menos 3 caracteres';
                                    }
                                    final emailRegex = RegExp(
                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                    );
                                    if (!emailRegex.hasMatch(text)) {
                                      return 'Digite um e-mail válido';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(
                                      63,
                                      81,
                                      181,
                                      1,
                                    ),
                                    foregroundColor: Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255,
                                    ),
                                  ),
                                  onPressed: enviar,
                                  child: Text('Salvar alterações'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 15,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color(0xFF1B1437),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawergeral(),
      appBar: Appbargeral(),
    );
  }
}
