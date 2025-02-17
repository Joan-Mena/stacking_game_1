import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacking_game_1/button.dart';
import 'package:stacking_game_1/pixel.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

// Primero definición de la clase homePage.
// Este widget representa la pantalla principal del juego.
class _homePageState extends State<homePage> {
  int numberOfSquares = 160; // Número total de cuadrados en la cuadrícula.
  List<int> piece = []; // Lista que almacena las posiciones de la pieza actual.
  var direction =
      "left"; // Dirección en la que se mueve la pieza (izquierda o derecha).
  List<int> landed = [
    100000
  ]; // Lista que almacena las posiciones de las piezas que han aterrizado.
  int level = 0;
  //metodo para iniciar el juego.
  void starGame() {
    piece = [
      // Inicializa la pieza en la parte inferior de la cuadrícula.
      numberOfSquares - 3 - level * 10,
      numberOfSquares - 2 - level * 10,
      numberOfSquares - 1 - level * 10
    ];
    Timer.periodic(Duration(milliseconds: 250), (timer) {
      // Temporizador que mueve la pieza cada 250 milisegundos.
      if (checkWinner()) {
        // Verificamos si el jugador ha ganado.
        _showDialog(); //mostramos un dialogo de vistoria si el jugador gano.
        timer.cancel(); //Detenemos el temporizador.
      }
      // Cambiamos la dirección de la pieza si llega a los bordes de la cuadrícula.
      if (piece.first % 10 == 0) {
        direction = "right";
      } else if (piece.last % 10 == 9) {
        direction = "left";
      }
      // Mueve la pieza en la dirección actual.
      setState(() {
        if (direction == "right") {
          for (int i = 0; i < piece.length; i++) {
            piece[i] += 1;
          }
        } else {
          for (int i = 0; i < piece.length; i++) {
            piece[i] -= 1;
          }
        }
      });
    });
  }

  // Método para verificar si el jugador ha ganado.
  bool checkWinner() {
    if (landed.last < 10) {
      //si la última pieza esta en la parte superior, el jugador ha ganado.
      return true;
    } else {
      return false;
    }
  }

  // Método para mostrar un diálogo de victoria.
  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext Context) {
          return AlertDialog(
            title: Text("Winner!!!"),
          );
        });
  }

  // Método para apilar la pieza actual y generar una nueva pieza.
  void stack() {
    setState(() {
      level++; //incrementamos el nivels
      for (int i = 0; i < piece.length; i++) {
        // Añade la pieza actual a la lista de piezas aterrizadas.
        landed.add(piece[i]);
      }
      if (level < 4) {
        // Genera una nueva pieza dependiendo del nivel.
        piece = [
          numberOfSquares - 3 - level * 10,
          numberOfSquares - 2 - level * 10,
          numberOfSquares - 1 - level * 10
        ];
      } else if (level >= 4 && level < 8) {
        piece = [
          numberOfSquares - 2 - level * 10,
          numberOfSquares - 1 - level * 10
        ];
      } else if (level >= 8) {
        piece = [numberOfSquares - 1 - level * 10];
      }
      checkStack(); // Verificamos y ajustamos la pila de piezas aterrizadas.
    });
  }

  // Con este método para verificar y ajustar la pila de piezas aterrizadas.
  void checkStack() {
    for (int i = 0; i < landed.length; i++) {
      // Eliminanos las piezas que no tienen soporte debajo.
      if (!landed.contains(landed[i] + 10) &&
          (landed[i] + 10) < numberOfSquares - 1) {
        landed.remove(landed[i]);
      }
    }
    for (int i = 0; i < landed.length; i++) {
      // Repite el proceso para asegurarse de que todas las piezas estén correctamente apiladas.
      if (!landed.contains(landed[i] + 10) &&
          (landed[i] + 10) < numberOfSquares - 1) {
        landed.remove(landed[i]);
      }
    }
  }

  // Método build que nos sirve para defir cómo se construye y muestra la interfaz de usuario.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800], // Color de fondo de la pantalla.
      body: Column(
        children: [
          // Cuadrícula que muestra los píxeles del juego.
          Expanded(
            flex: 5,
            child: GridView.builder(
                itemCount: numberOfSquares, // Número total de cuadrados.
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        10), // definnimos 10 columnas en la cuadrícula.
                itemBuilder: (BuildContext context, int index) {
                  if (piece.contains(index)) {
                    // Si el índice está en la lista de la pieza actual, muestra un píxel blanco.
                    return MyPixel(
                      color: Colors.white,
                    );
                  } else if (landed.contains(index)) {
                    // Si el índice está en la lista de piezas aterrizadas, muestra un píxel blanco.
                    return MyPixel(
                      color: Colors.white,
                    );
                  } else {
                    // De lo contrario, muestra un píxel negro
                    return MyPixel(
                      color: Colors.black,
                    );
                  }
                }),
          ),
          Expanded(
            // Contenedor inferior con los botones de PLAY y STOP.
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Mybutton(
                    // Botón "PLAY" que inicia el juego.
                    function: starGame,
                    child: Text(
                      "P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Mybutton(
                    // Botón "STOP" que apila la pieza actual
                    function: stack,
                    child: Text(
                      "S T O P",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
