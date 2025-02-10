import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stacking_game_1/button.dart';
import 'package:stacking_game_1/pixel.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int numberOfSquares = 160;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GridView.builder(
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10),
                itemBuilder: (BuildContext context, int index) {
                  return MyPixel(
                    color: Colors.black,
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Mybutton(
                    child: Text(
                      "P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  Mybutton(
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
