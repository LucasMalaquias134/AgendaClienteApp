import 'package:agendacliente/modelo/classes/password.dart';
import 'package:agendacliente/modelo/local_storage_service.dart';

class Passwordcontroller {
  static Future<bool> verSessao() async {
    try {
      Password? senha = await LocalStorageService.carregarSenha();
      if (senha == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return true;
    }
  }

  static Future<bool> comparaSenha(String senha) async {
    try {
      Password? password = await LocalStorageService.carregarSenha();
      if (password == null) {
        return false;
      }
      if (password.senha == senha) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> apagaSenha() async {
    try {
      bool resultado = await LocalStorageService.apagarSenha();
      return resultado;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> salvarSenha(String senha) async {
    try {
      Password password = Password(senha: senha);
      await LocalStorageService.salvarSenha(password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
