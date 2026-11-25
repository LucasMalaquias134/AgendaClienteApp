import 'package:agendacliente/modelo/local_storage_service.dart';

class PrefsService {
  PrefsService._();
  static final PrefsService instance = PrefsService._();

  int cor = 1;

  Future<void> init() async {
    cor = (await LocalStorageService.carregarUsuario())?.cor ?? 1;
  }
}
