import 'package:agendacliente/ajudantes/cores.dart';
import 'package:agendacliente/modelo/singleton.dart';
import 'package:flutter/material.dart';

class Appbargeral extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  final bool? leading;
  const new({required this.titulo, this.leading, super.key});

  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    Map<String, Color> cores = corAjuda.getMetod(PrefsService.instance.cor);
    return AppBar(
      title: Text(titulo, style: TextStyle(color: cores['corDeTexto'])),
      backgroundColor: cores['corDeFundo2'],
      leading: (leading == true)
          ? BackButton(color: cores['corDeTexto'])
          : null,
      iconTheme: IconThemeData(color: cores['corDeTexto']),
    );
  }
}
