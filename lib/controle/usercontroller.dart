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

  static Future<bool> apagarImg() async {
    try {
      User? usuario = await LocalStorageService.carregarUsuario();
      if (usuario == null) {
        return false;
      } else {
        usuario.urlImage = '';
        await LocalStorageService.salvarUsuario(usuario);
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> salvarImg(String url) async {
    try {
      User? usuario = await LocalStorageService.carregarUsuario();

      if (usuario != null) {
        usuario.urlImage = url;

        await LocalStorageService.salvarUsuario(usuario);

        return true;
      } else {
        User usuario = User(urlImage: url, cor: 1);
        await LocalStorageService.salvarUsuario(usuario);
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> salvarCor(int valor) async {
    try {
      User? usuario = await LocalStorageService.carregarUsuario();

      if (usuario != null) {
        usuario.cor = valor;

        await LocalStorageService.salvarUsuario(usuario);

        return true;
      } else {
        User usuario = User(cor: valor);
        await LocalStorageService.salvarUsuario(usuario);
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
