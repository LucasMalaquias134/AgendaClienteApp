import 'package:agendacliente/modelo/classes/servicos.dart';
import 'package:agendacliente/modelo/local_storage_service.dart';

class Servicoscontroller {
  static Future<List<Servico>> carregarServicos(String? pesquisa) async {
    try {
      List<Servico> servicos = await LocalStorageService.carregarServicos();
      if (pesquisa != null && pesquisa.trim().isNotEmpty) {
        servicos = servicos
            .where(
              (element) =>
                  element.nome.toLowerCase().contains(pesquisa.toLowerCase()),
            )
            .toList();
      }
      return servicos;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<bool> criarServico(
    String nome,
    String? desc,
    double preco,
  ) async {
    try {
      List<Servico> servicos = await LocalStorageService.carregarServicos();
      Servico novoServico = Servico(
        id: DateTime.now().millisecondsSinceEpoch,
        nome: nome,
        descricao: desc,
        preco: preco,
      );
      servicos.add(novoServico);
      await LocalStorageService.salvarServicos(servicos);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> editarServico(
    int id,
    String? nome,
    String? desc,
    double? preco,
  ) async {
    try {
      List<Servico> listaServico = await LocalStorageService.carregarServicos();

      Servico servicoAchado = listaServico.firstWhere(
        (element) => element.id == id,
      );

      if (nome != null && nome.trim().isNotEmpty) {
        servicoAchado.nome = nome;
      }
      if (desc != null && desc.trim().isNotEmpty) {
        servicoAchado.descricao = desc;
      }
      if (preco != null && preco >= 0) {
        servicoAchado.preco = preco;
      }

      await LocalStorageService.salvarServicos(listaServico);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> apagarServico(int id) async {
    try {
      List<Servico> listaServico = await LocalStorageService.carregarServicos();

      listaServico.removeWhere((element) => element.id == id);

      await LocalStorageService.salvarServicos(listaServico);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
