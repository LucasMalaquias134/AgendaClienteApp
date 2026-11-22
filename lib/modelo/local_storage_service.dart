import 'dart:convert';

import 'package:agendacliente/modelo/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String LISTA_USERS = 'lista_users';

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

  //===============================================================================================
}
