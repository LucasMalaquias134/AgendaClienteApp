import 'package:agendacliente/modelo/classes/user.dart';
import 'package:agendacliente/modelo/local_storage_service.dart';

class Usercontroller {
  static Future<bool> salvarUser(String nome, String email) async {
    try {
      User? usuario = await LocalStorageService.carregarUsuario();

      if (usuario != null) {
        usuario.name = nome;
        usuario.email = email;

        await LocalStorageService.salvarUsuario(usuario);

        return true;
      } else {
        User usuario = new User(name: nome, email: email, cor: 1);
        await LocalStorageService.salvarUsuario(usuario);
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
