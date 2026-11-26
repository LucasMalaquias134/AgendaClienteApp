import 'dart:convert';

import 'package:agendacliente/modelo/classes/agendamento.dart';
import 'package:agendacliente/modelo/classes/clientes.dart';
import 'package:agendacliente/modelo/classes/lucro.dart';
import 'package:agendacliente/modelo/classes/password.dart';
import 'package:agendacliente/modelo/classes/prejuizo.dart';
import 'package:agendacliente/modelo/classes/saldo.dart';
import 'package:agendacliente/modelo/classes/servicos.dart';
import 'package:agendacliente/modelo/classes/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String LISTA_USERS = 'lista_users';
  static const String PASSWORDKEY = 'passwordkey';
  static const String LISTA_SERVICOS = 'lista_servicos';
  static const String LISTA_SALDO = 'lista_saldo';
  static const String LISTA_PREJUIZO = 'lista_prejuizo';
  static const String LISTA_LUCRO = 'lista_lucro';
  static const String LISTA_CLIENTES = 'lista_clientes';
  static const String LISTA_AGENDAMENTO = 'lista_agendamento';

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

  //===Recurso do Servicos==========================================================================
  static Future<void> salvarServicos(List<Servico> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Servico.encode(lista);
    await prefs.setString(LISTA_SERVICOS, encodedData);
  }

  static Future<List<Servico>> carregarServicos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? listaJson = prefs.getString(LISTA_SERVICOS);

    if (listaJson == null) return [];

    return Servico.decode(listaJson);
  }

  //===Recurso do Saldo==========================================================================
  static Future<void> salvarSaldos(List<Saldo> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Saldo.encode(lista);
    await prefs.setString(LISTA_SALDO, encodedData);
  }

  static Future<List<Saldo>> carregarSaldos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? listaJson = prefs.getString(LISTA_SALDO);

    if (listaJson == null) return [];

    return Saldo.decode(listaJson);
  }

  //===Recurso do Prejuizo==========================================================================
  static Future<void> salvarPrejuizos(List<Prejuizo> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Prejuizo.encode(lista);
    await prefs.setString(LISTA_PREJUIZO, encodedData);
  }

  static Future<List<Prejuizo>> carregarPrejuizos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? listaJson = prefs.getString(LISTA_PREJUIZO);

    if (listaJson == null) return [];

    return Prejuizo.decode(listaJson);
  }

  //===Recurso do Lucro==========================================================================
  static Future<void> salvarLucros(List<Lucro> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Lucro.encode(lista);
    await prefs.setString(LISTA_LUCRO, encodedData);
  }

  static Future<List<Lucro>> carregarLucros() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? listaJson = prefs.getString(LISTA_LUCRO);

    if (listaJson == null) return [];

    return Lucro.decode(listaJson);
  }

  //===Recurso do cliente==========================================================================
  static Future<void> salvarClientes(List<Cliente> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Cliente.encode(lista);
    await prefs.setString(LISTA_CLIENTES, encodedData);
  }

  static Future<List<Cliente>> carregarClientes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? listaJson = prefs.getString(LISTA_CLIENTES);

    if (listaJson == null) return [];

    return Cliente.decode(listaJson);
  }

  //===Recurso do agendamento==========================================================================
  static Future<void> salvarAgendamento(List<Agendamento> lista) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = Agendamento.encode(lista);
    await prefs.setString(LISTA_AGENDAMENTO, encodedData);
  }

  static Future<List<Agendamento>> carregarAgendamento() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? listaJson = prefs.getString(LISTA_AGENDAMENTO);

    if (listaJson == null) return [];

    return Agendamento.decode(listaJson);
  }
}
