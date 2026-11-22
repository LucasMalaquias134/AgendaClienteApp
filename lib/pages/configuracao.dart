import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/drawergeral.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/controle/usercontroller.dart';
import 'package:agendacliente/modelo/classes/user.dart';
import 'package:agendacliente/modelo/local_storage_service.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class Configuracao extends StatefulWidget {
  const new({super.key});

  @override
  State<Configuracao> createState() => _ConfiguracaoState();
}

class _ConfiguracaoState extends State<Configuracao> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  User usuario = User(cor: 1);

  final formKey = GlobalKey<FormState>();

  String? imagemSelecionada;
  final ImagePicker picker = ImagePicker();

  Future<void> _pegarImagem() async {
    final XFile? arquivo = await picker.pickImage(source: ImageSource.gallery);
    if (arquivo != null) {
      final String caminhoImagem = arquivo.path;
      await Usercontroller.salvarImg(caminhoImagem);

      setState(() {
        imagemSelecionada = caminhoImagem;
        usuario.urlImage = imagemSelecionada;
      });
    }
  }

  Future<void> carregarDados() async {
    try {
      User usuarioAchado =
          (await LocalStorageService.carregarUsuario()) ?? (User(cor: 1));
      setState(() {
        usuario = usuarioAchado;
        namecontroller.text = usuario.name ?? '';
        emailcontroller.text = usuario.email ?? '';
      });
    } catch (e) {
      print("Sem dados persistidos ( metodo carregar dados ) $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    emailcontroller.dispose();
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
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
          usuario.name = namecontroller.text;
          usuario.email = emailcontroller.text;
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
              onPressed: () => Navigator.of(context).pop(2),
              child: Text('Editar'),
            ),
          ],
        );
      },
    );

    if (confirmado == 2) {
      _pegarImagem();
    }
  }

  Future<void> apagaFoto(BuildContext context) async {
    final bool? confirmado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar Foto'),
          content: Text('Deseja realmente apagar sua foto?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Apagar'),
            ),
          ],
        );
      },
    );

    if (confirmado == true) {
      bool resultado = await Usercontroller.apagarImg();
      if (resultado) {
        setState(() {
          usuario.urlImage = '';
        });
      }
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
                              onSelected: (String opcao) async {
                                switch (opcao) {
                                  case '1':
                                    editarFoto(context);
                                    break;
                                  case '2':
                                    apagaFoto(context);
                                    break;
                                  case '3':
                                    break;
                                  case '4':
                                    bool resultado =
                                        await LocalStorageService.apagarUsuario();
                                    if (resultado) {
                                      setState(() {
                                        usuario = User(cor: 1);
                                      });
                                    }
                                    break;
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
                                PopupMenuItem<String>(
                                  value: '4',
                                  child: ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text('Deletar User'),
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: '5',
                                  child: ListTile(
                                    leading: Icon(Icons.shield),
                                    title: Text('Segurança'),
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
                                  placeHolder2: usuario.name,
                                  controller: namecontroller,
                                ),
                                SizedBox(height: 20),
                                Textfieldajudante(
                                  placeHolder: 'Email',
                                  labelFlutante: true,
                                  placeHolder2: usuario.email,
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
                  /*  */
                  Positioned(
                    top: 15,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Color.fromARGB(255, 19, 13, 38),
                      child:
                          usuario.urlImage == null || usuario.urlImage!.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            )
                          : ClipOval(
                              child: SizedBox(
                                width: 110,
                                height: 110,
                                child: Image.file(
                                  File(usuario.urlImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
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
      appBar: Appbargeral(titulo: 'Configurações'),
    );
  }
}
