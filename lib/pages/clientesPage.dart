import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/ajudantes/drawergeral.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/controle/clientesController.dart';
import 'package:agendacliente/modelo/classes/clientes.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:agendacliente/pages/criaclientePage.dart';
import 'package:agendacliente/pages/editaclientePage.dart';
import 'package:flutter/material.dart';

class Clientespage extends StatefulWidget {
  const new({super.key});

  @override
  State<Clientespage> createState() => _ClientespageState();
}

class _ClientespageState extends State<Clientespage> {
  TextEditingController pesquisaController = TextEditingController();

  bool carregando = true;

  List<Cliente> clientes = [];

  Future<void> carregarDados() async {
    try {
      List<Cliente> clienteLista = await Clientescontroller.carregarClientes(
        null,
      );
      setState(() {
        clientes = clienteLista;
        carregando = false;
      });
    } catch (e) {
      print("Sem dados persistidos ( metodo carregar dados ) $e");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<bool> enviar(int id) async {
    int indice = clientes.indexWhere((item) => item.id == id);

    final bool? confirmado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deseja apagar?'),
          content: Text(
            'Realmente deseja apagar o(a) cliente ${clientes[indice].nome} ?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Não'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Sim'),
            ),
          ],
        );
      },
    );

    if (confirmado == true) {
      bool resultado = await Clientescontroller.apagarCliente(id);

      if (resultado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Salvo Com sucesso'),
            backgroundColor: Colors.green,
          ),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Algo de Errado, tente de novo'),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Color> cores = corAjuda.getMetod(PrefsService.instance.cor);
    return Scaffold(
      backgroundColor: cores['corDeFundoPrincipal'],
      body: carregando
          ? Center(
              child: Padding(
                padding: EdgeInsetsGeometry.all(50),
                child: LinearProgressIndicator(
                  color: cores['corDeBotao'],
                  backgroundColor: Colors.transparent,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Column(
                children: [
                  Textfieldajudante(
                    temaEscuro: (PrefsService.instance.cor == 1) ? false : true,
                    placeHolder: 'Pesquisar',
                    placeHolder2: '',
                    controller: pesquisaController,
                    enviado: (p0) async {
                      List<Cliente> clienteLista =
                          await Clientescontroller.carregarClientes(p0);
                      setState(() {
                        clientes = clienteLista;
                      });
                    },
                  ),
                  SizedBox(height: 25),
                  if (clientes.isEmpty) ...[
                    Center(
                      child: Text(
                        (pesquisaController.text.trim().isNotEmpty)
                            ? 'Não há cliente cadastrado com esse nome : ${pesquisaController.text}'
                            : 'Não há cliente cadastrado!',
                        style: TextStyle(color: cores['corDeTexto']),
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: ListView.builder(
                        itemCount: clientes.length,
                        itemBuilder: (BuildContext context, index) {
                          final cliente = clientes[index];
                          return Dismissible(
                            key: ValueKey(cliente.id),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Editaclientepage(cliente: cliente),
                                  ),
                                );
                                List<Cliente> clienteLista =
                                    await Clientescontroller.carregarClientes(
                                      pesquisaController.text,
                                    );
                                setState(() {
                                  clientes = clienteLista;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.all(5),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: cores['corDeFundo2'],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      cliente.nome,
                                      style: TextStyle(
                                        color: cores['corDeTexto'],
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.edit,
                                      color: cores['corDeTexto'],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              bool resultado = await enviar(cliente.id);
                              return resultado;
                            },
                            onDismissed: (direction) {
                              setState(() {
                                clientes.removeAt(index);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
      drawer: Drawergeral(),
      appBar: Appbargeral(titulo: 'Seus Clientes'),
      floatingActionButton: carregando
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Criaclientepage()),
                );
              },
              backgroundColor: cores['corDeBotao'],
              child: Icon(Icons.add, color: Colors.white),
            ),
    );
  }
}
