import 'package:agendacliente/ajudantes/appbargeral.dart';
import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/ajudantes/drawergeral.dart';
import 'package:agendacliente/ajudantes/textfieldajudante.dart';
import 'package:agendacliente/controle/servicosController.dart';
import 'package:agendacliente/modelo/classes/servicos.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:agendacliente/pages/criaservicoPage.dart';
import 'package:agendacliente/pages/editaservicoPage.dart';
import 'package:flutter/material.dart';

class Servicospage extends StatefulWidget {
  const new({super.key});

  @override
  State<Servicospage> createState() => _ServicospageState();
}

class _ServicospageState extends State<Servicospage> {
  TextEditingController pesquisaController = TextEditingController();

  bool carregando = true;

  List<Servico> servicos = [];

  Future<void> carregarDados() async {
    try {
      List<Servico> servicoLista = await Servicoscontroller.carregarServicos(
        null,
      );
      setState(() {
        servicos = servicoLista;
        carregando = false;
      });
    } catch (e) {
      print("Sem dados persistidos ( metodo carregar dados ) $e");
    }
  }

  @override
  void dispose() {
    pesquisaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<bool> enviar(int id) async {
    int indice = servicos.indexWhere((item) => item.id == id);

    final bool? confirmado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deseja apagar?'),
          content: Text(
            'Realmente deseja apagar o(a) serviço ${servicos[indice].nome} ?',
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
      bool resultado = await Servicoscontroller.apagarServico(id);

      if (resultado) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Apagado Com sucesso'),
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
                      List<Servico> servicoLista =
                          await Servicoscontroller.carregarServicos(p0);
                      setState(() {
                        servicos = servicoLista;
                      });
                    },
                  ),
                  SizedBox(height: 25),
                  if (servicos.isEmpty) ...[
                    Center(
                      child: Text(
                        (pesquisaController.text.trim().isNotEmpty)
                            ? 'Não há serviços cadastrado com esse nome : ${pesquisaController.text}'
                            : 'Não há serviço cadastrado!',
                        style: TextStyle(color: cores['corDeTexto']),
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: ListView.builder(
                        itemCount: servicos.length,
                        itemBuilder: (BuildContext context, index) {
                          final servico = servicos[index];
                          return Dismissible(
                            key: ValueKey(servico.id),
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
                                        Editaservicopage(servico: servico),
                                  ),
                                );
                                List<Servico> servicoLista =
                                    await Servicoscontroller.carregarServicos(
                                      pesquisaController.text,
                                    );
                                setState(() {
                                  servicos = servicoLista;
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
                                      servico.nome,
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
                              bool resultado = await enviar(servico.id);
                              return resultado;
                            },
                            onDismissed: (direction) {
                              setState(() {
                                servicos.removeAt(index);
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
      appBar: Appbargeral(titulo: 'Seus serviços'),
      floatingActionButton: carregando
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Criaservicopage()),
                );
              },
              backgroundColor: cores['corDeBotao'],
              child: Icon(Icons.add, color: Colors.white),
            ),
    );
  }
}
