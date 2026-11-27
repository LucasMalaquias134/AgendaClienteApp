import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/controle/servicosController.dart';
import 'package:agendacliente/modelo/classes/servicos.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:flutter/material.dart';

class Editaservicopage extends StatefulWidget {
  final Servico servico;
  const new({required this.servico, super.key});

  @override
  State<Editaservicopage> createState() => _EditaservicopageState();
}

class _EditaservicopageState extends State<Editaservicopage> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController precocontroller = TextEditingController();

  late Servico servicoEstado;

  @override
  void initState() {
    super.initState();
    servicoEstado = widget.servico;
  }

  @override
  void dispose() {
    namecontroller.dispose();
    desccontroller.dispose();
    precocontroller.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  void enviar() async {
    if (formKey.currentState!.validate()) {
      bool resultado = await Servicoscontroller.editarServico(
        widget.servico.id,
        namecontroller.text,
        desccontroller.text,
        double.tryParse(precocontroller.text),
      );

      if (resultado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Salvo Com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
        setState(() {
          servicoEstado.nome = (namecontroller.text.trim().isNotEmpty)
              ? namecontroller.text
              : servicoEstado.nome;
          servicoEstado.descricao = (desccontroller.text.trim().isNotEmpty)
              ? desccontroller.text
              : servicoEstado.descricao;
          servicoEstado.preco = (precocontroller.text.trim().isNotEmpty)
              ? double.parse(precocontroller.text)
              : servicoEstado.preco;
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
                    'Nome do Serviço',
                    style: TextStyle(color: cores['corDeTexto'], fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Divider(),
                  SizedBox(height: 5),
                  Text(
                    widget.servico.nome,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Preço do Serviço',
                    style: TextStyle(color: cores['corDeTexto'], fontSize: 17),
                  ),
                  Spacer(),
                  Text(
                    'R\$ ${widget.servico.preco.toStringAsFixed(2)}',
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
                    'Descrição do Serviço',
                    style: TextStyle(color: cores['corDeTexto'], fontSize: 17),
                  ),
                  SizedBox(height: 5),
                  Divider(),
                  SizedBox(height: 5),
                  Text(
                    (widget.servico.descricao != null &&
                            widget.servico.descricao!.trim().isNotEmpty)
                        ? widget.servico.descricao!
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                          placeHolder: 'Novo Nome do Serviço (opcional)',
                          placeHolder2: '',
                          controller: namecontroller,
                        ),
                        SizedBox(height: 15),
                        Textfieldajudante(
                          temaEscuro: (PrefsService.instance.cor == 1)
                              ? false
                              : true,
                          placeHolder: 'Novo Preço do Serviço (opcional)',
                          placeHolder2: '',
                          controller: precocontroller,
                          numerico: true,
                        ),
                        SizedBox(height: 15),
                        Textfieldajudante(
                          temaEscuro: (PrefsService.instance.cor == 1)
                              ? false
                              : true,
                          placeHolder: 'Nova Descrição do Serviço (opcional)',
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
