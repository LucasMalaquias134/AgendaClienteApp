import 'package:agendacliente/modelo/classes/clientes.dart';
import 'package:agendacliente/modelo/local_storage_service.dart';

class Clientescontroller {
  static Future<List<Cliente>> carregarClientes(String? pesquisa) async {
    try {
      List<Cliente> clientes = await LocalStorageService.carregarClientes();
      if (pesquisa != null && pesquisa.trim().isNotEmpty) {
        clientes = clientes
            .where(
              (element) =>
                  element.nome.toLowerCase().contains(pesquisa.toLowerCase()),
            )
            .toList();
      }
      return clientes;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<bool> criarCliente(String nome, String? desc) async {
    try {
      List<Cliente> clientes = await LocalStorageService.carregarClientes();
      Cliente novoCliente = Cliente(
        id: DateTime.now().millisecondsSinceEpoch,
        nome: nome,
        descricao: desc,
      );
      clientes.add(novoCliente);
      await LocalStorageService.salvarClientes(clientes);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> editarCliente(int id, String? nome, String? desc) async {
    try {
      List<Cliente> listaCliente = await LocalStorageService.carregarClientes();

      Cliente clienteAchado = listaCliente.firstWhere(
        (element) => element.id == id,
      );

      if (nome != null && nome.trim().isNotEmpty) {
        clienteAchado.nome = nome;
      }
      if (desc != null && desc.trim().isNotEmpty) {
        clienteAchado.descricao = desc;
      }

      await LocalStorageService.salvarClientes(listaCliente);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> apagarCliente(int id) async {
    try {
      List<Cliente> listaCliente = await LocalStorageService.carregarClientes();

      listaCliente.removeWhere((element) => element.id == id);

      await LocalStorageService.salvarClientes(listaCliente);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
