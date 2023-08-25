import 'package:flutter/material.dart';
import 'package:sokoban/ListGame.dart';

class Sokoban extends StatefulWidget {
  const Sokoban({Key? key}) : super(key: key);

  @override
  _SokobanState createState() => _SokobanState();
}

class _SokobanState extends State<Sokoban> {


  int playerX = 1;
  int playerY = 1;

  void movePlayer(int dx, int dy) {
    int newPlayerX = playerX + dx;
    int newPlayerY = playerY + dy;

    if (game1[newPlayerX][newPlayerY] == "0" ||
        game1[newPlayerX][newPlayerY] == "4") {
      setState(() {
        if (game1[newPlayerX][newPlayerY] == "4") {

          game1[newPlayerX][newPlayerY] = "2";
        } else {
          game1[newPlayerX][newPlayerY] = "2";
        }
        game1[playerX][playerY] = "0";
        playerX = newPlayerX;
        playerY = newPlayerY;
      });
    } else if (game1[newPlayerX][newPlayerY] == "3") {

      int newBoxX = newPlayerX + dx;
      int newBoxY = newPlayerY + dy;

      if (game1[newBoxX][newBoxY] == "0" || game1[newBoxX][newBoxY] == "4") {
        setState(() {
          if (game1[newBoxX][newBoxY] == "4") {
            game1[newBoxX][newBoxY] = "3";
          } else {
            game1[newBoxX][newBoxY] = "3";
          }
          game1[newPlayerX][newPlayerY] = "2";
          game1[playerX][playerY] = "0";
          playerX = newPlayerX;
          playerY = newPlayerY;
        });
      }
    }
    if (_checkWinCondition()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Congratulations!"),
            content: Text("You've cleared all the targets and completed the level."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // You can add further actions here, like moving to the next level.
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  bool _checkWinCondition() {
    for (var row in game1) {
      for (var cell in row) {
        if (cell == "4") {
          return false; // There's still an uncleared target
        }
      }
    }
    return true; // All targets are cleared
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(

        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 200,),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(game1.length, (row) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(game1[row].length, (col) {
                          return Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: _buildTile(game1[row][col]),
                          );
                        }),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  width: 400,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){
                        movePlayer(1, 0);
                      }, icon: Icon(Icons.arrow_downward)),
                      IconButton(onPressed: (){
                        movePlayer(-1, 0);
                      }, icon: Icon(Icons.arrow_upward)),
                      IconButton(onPressed: (){
                        movePlayer(0, -1);
                      }, icon: Icon(Icons.arrow_back)),
                      IconButton(onPressed: (){
                        movePlayer(0, 1);
                      }, icon: Icon(Icons.arrow_right)),
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  Widget _buildTile(String value){
    switch(value){
      case "1":
        return Container(color: Colors.grey,);
      case "2":
        return Container(color: Colors.red,);
      case "3":
        return Container(color: Colors.brown,);
      case "4":
        return Container(color: Colors.black,);
      default:
        return Container();
    }
  }
}
