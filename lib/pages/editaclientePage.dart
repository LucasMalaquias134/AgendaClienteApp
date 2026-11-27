import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/controle/clientesController.dart';
import 'package:agendacliente/modelo/classes/clientes.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:flutter/material.dart';

class Editaclientepage extends StatefulWidget {
  final Cliente cliente;
  const new({required this.cliente, super.key});

  @override
  State<Editaclientepage> createState() => _EditaclientepageState();
}

class _EditaclientepageState extends State<Editaclientepage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();

  late Cliente clienteEstado;

  @override
  void initState() {
    super.initState();
    clienteEstado = widget.cliente;
  }

  @override
  void dispose() {
    namecontroller.dispose();
    desccontroller.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  void enviar() async {
    if (formKey.currentState!.validate()) {
      bool resultado = await Clientescontroller.editarCliente(
        widget.cliente.id,
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
        setState(() {
          clienteEstado.nome = (namecontroller.text.trim().isNotEmpty)
              ? namecontroller.text
              : clienteEstado.nome;
          clienteEstado.descricao = (desccontroller.text.trim().isNotEmpty)
              ? desccontroller.text
              : clienteEstado.descricao;
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
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: cores['corDeFundo2'],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome do Cliente',
                    style: TextStyle(color: cores['corDeTexto'], fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Divider(),
                  SizedBox(height: 5),
                  Text(
                    widget.cliente.nome,
                    style: TextStyle(color: cores['corDeTexto'], fontSize: 17),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: cores['corDeFundo2'],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descrição do Cliente',
                    style: TextStyle(color: cores['corDeTexto'], fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Divider(),
                  SizedBox(height: 5),
                  Text(
                    (widget.cliente.descricao != null &&
                            widget.cliente.descricao!.trim().isNotEmpty)
                        ? widget.cliente.descricao!
                        : 'Sem Descrição',
                    style: TextStyle(color: cores['corDeTexto'], fontSize: 17),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: cores['corDeFundo2'],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.edit, color: cores['corDeTexto']),
                      SizedBox(width: 10),
                      Text(
                        'Editar',
                        style: TextStyle(
                          color: cores['corDeTexto'],
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Textfieldajudante(
                          temaEscuro: (PrefsService.instance.cor == 1)
                              ? false
                              : true,
                          placeHolder: 'Novo Nome do Cliente (opcional)',
                          placeHolder2: '',
                          controller: namecontroller,
                        ),
                        SizedBox(height: 15),
                        Textfieldajudante(
                          temaEscuro: (PrefsService.instance.cor == 1)
                              ? false
                              : true,
                          placeHolder: 'Nova Descrição do Cliente (opcional)',
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
                          child: Text('Salvar alteração'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: Appbargeral(titulo: 'Editar', leading: true),
    );
  }
}
