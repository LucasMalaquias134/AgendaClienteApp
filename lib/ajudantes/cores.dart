import 'package:flutter/material.dart';

class corAjuda {
  static Color corDeFundoPrincipal = Color.fromARGB(255, 36, 23, 76);
  static Color corDeFundo2 = Color.fromARGB(255, 19, 13, 38);
  static Color corDeTexto = Color.fromARGB(255, 255, 255, 255);
  static Color corDeBotao = Color.fromARGB(255, 0, 106, 245);

  static Color corDeFundoPrincipalBBB = Color.fromARGB(255, 230, 229, 232);
  static Color corDeFundo2BBB = Color.fromARGB(255, 255, 255, 255);
  static Color corDeTextoBBB = Color.fromARGB(255, 0, 0, 0);
  static Color corDeBotaoBBB = Color.fromARGB(255, 0, 106, 245);

  static Map<String, Color> getMetod(int valor) {
    switch (valor) {
      case 1:
        return {
          'corDeFundoPrincipal': corDeFundoPrincipal,
          'corDeFundo2': corDeFundo2,
          'corDeTexto': corDeTexto,
          'corDeBotao': corDeBotao,
        };
      case 2:
        return {
          'corDeFundoPrincipal': corDeFundoPrincipalBBB,
          'corDeFundo2': corDeFundo2BBB,
          'corDeTexto': corDeTextoBBB,
          'corDeBotao': corDeBotaoBBB,
        };
      default:
        return {
          'corDeFundoPrincipal': corDeFundoPrincipal,
          'corDeFundo2': corDeFundo2,
          'corDeTexto': corDeTexto,
          'corDeBotao': corDeBotao,
        };
    }
  }

  // static List<Color> setmetod(){

  // }
}
