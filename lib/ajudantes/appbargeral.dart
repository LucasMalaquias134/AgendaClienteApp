import 'package:flutter/material.dart';

class Appbargeral extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;
  const new({required this.titulo, super.key});

  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        titulo,
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      backgroundColor: Color.fromARGB(255, 19, 13, 38),
      iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
    );
  }
}
