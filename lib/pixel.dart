import 'package:flutter/material.dart';

class MyPixel extends StatelessWidget {
  final color;

  MyPixel(
      {this.color}); // Constructor del píxel. Recibe el `color` como parámetro.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        // con ClipRRect recortamos el contenido con bordes redondeados.
        borderRadius: BorderRadius.circular(6),
        child: Container(
          color: color, // Color de fondo del píxel, que se pasa como parámetro.
        ),
      ),
    );
  }
}
