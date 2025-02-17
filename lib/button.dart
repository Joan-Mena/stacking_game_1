import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  final child;
  final function;

  Mybutton({this.child, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Aquí se define que cuando el usuario toque el botón, se ejecutará la función `function'
      onTap: function,
      child: Padding(
        // con el Padding agrega un espacio alrededor del contenido del botón.
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          // ClipRRect recorta el contenido con bordes redondeados.
          borderRadius: BorderRadius.circular(10),
          child: Container(
            //con este widget podemos personalizar el fondo, el padding, etc.
            padding: EdgeInsets.all(20), // Padding interno del botón.
            color: Colors.grey[900], // Color de fondo del botón (gris oscuro).
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
