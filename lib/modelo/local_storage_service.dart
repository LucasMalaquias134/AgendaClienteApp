import 'dart:convert';

import 'package:agendacliente/modelo/classes/password.dart';
import 'package:agendacliente/modelo/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String LISTA_USERS = 'lista_users';
  static const String PASSWORDKEY = 'passwordkey';

  //===Recurso do usuario==========================================================================
  static Future<void> salvarUsuario(User usuario) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(usuario.toMap());
    await prefs.setString(LISTA_USERS, encodedData);
  }

  static Future<User?> carregarUsuario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? usuariosJson = prefs.getString(LISTA_USERS);

    if (usuariosJson == null) return null;

    return User.fromMap(json.decode(usuariosJson));
  }

  //========================================================================================

  static Future<bool> apagarUsuario() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(LISTA_USERS);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //========================================================================================

  //===Recurso da password==========================================================================
  static Future<void> salvarSenha(Password senha) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(senha.toMap());
    await prefs.setString(PASSWORDKEY, encodedData);
  }

  static Future<Password?> carregarSenha() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? passwordJson = prefs.getString(PASSWORDKEY);

    if (passwordJson == null) return null;

    return Password.fromMap(json.decode(passwordJson));
  }

  static Future<bool> apagarSenha() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(PASSWORDKEY);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //========================================================================================
}
