import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/drawergeral.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:flutter/material.dart';

enum AcaoMenu { editar, compartilhar, excluir }

class Configuracao extends StatefulWidget {
  const new({super.key});

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  String _ultimaAcao = 'Nenhuma ação selecionada';

  TextEditingController controllerteste = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  void _enviar() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail válido: ${controllerteste.text}')),
      );
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
                alignment: AlignmentGeometry.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            PopupMenuButton<AcaoMenu>(
                              iconColor: Colors.white,
                              position: PopupMenuPosition.under,
                              onSelected: (AcaoMenu acao) {
                                setState(() {
                                  _ultimaAcao = switch (acao) {
                                    AcaoMenu.editar => 'Editar selecionado',
                                    AcaoMenu.compartilhar =>
                                      'Compartilhar selecionado',
                                    AcaoMenu.excluir => 'Excluir selecionado',
                                  };
                                });
                              },
                              itemBuilder: (BuildContext context) => const [
                                PopupMenuItem<AcaoMenu>(
                                  value: AcaoMenu.editar,
                                  child: ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Editar'),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                PopupMenuItem<AcaoMenu>(
                                  value: AcaoMenu.compartilhar,
                                  child: ListTile(
                                    leading: Icon(Icons.share),
                                    title: Text('Compartilhar'),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                PopupMenuDivider(),
                                PopupMenuItem<AcaoMenu>(
                                  value: AcaoMenu.excluir,
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    title: Text(
                                      'Excluir',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 75),
                      SizedBox(
                        //MUDA A COR AQUIIIIII

                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Textfieldajudante(
                                placeHolder: 'Nome',
                                labelFlutante: true,
                                placeHolder2:
                                    PrefsService.instance.usuario?.name,
                                controller: controllerteste,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _enviar,
                                child: const Text('Enviar'),
                              ),
                            ],
                          ),
                        ),
                      ),
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
            ],
          ),
        ),
      ),
      drawer: Drawergeral(),
      appBar: Appbargeral(),
    );
  }
}
