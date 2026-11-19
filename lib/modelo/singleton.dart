import 'package:agendacliente/modelo/classes/user.dart';
import 'package:agendacliente/modelo/local_storage_service.dart';

class PrefsService {
  PrefsService._();
  static final PrefsService instance = PrefsService._();

  User? usuario;

  Future<void> init() async {
    usuario = await LocalStorageService.carregarUsuario();
  }

  Future<void> salvarNome(String novoNome) async {
    // nomeUsuario = novoNome; // Atualiza na hora para as telas
    // await _prefs.setString('nome_usuario', novoNome); // Salva no disco
  }
}
