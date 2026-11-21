import 'package:agendacliente/modelo/classes/user.dart';
import 'package:agendacliente/modelo/local_storage_service.dart';

class PrefsService {
  PrefsService();
  static final PrefsService instance = PrefsService();

  User? usuario;

  Future<void> init() async {
    usuario = await LocalStorageService.carregarUsuario();
  }

  Future<void> salvarNome(
    String? nome,
    String? email,
    String? urlImage,
    int? cor,
  ) async {
    usuario?.name = nome;
    usuario?.email = email;
    usuario?.urlImage = urlImage;
    usuario?.cor = cor ?? 1;
  }
}
