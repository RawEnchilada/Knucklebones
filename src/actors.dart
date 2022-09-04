import 'dart:math';
import 'director.dart';
import 'state.dart';

abstract class Actor{
    Director director;
    Actor(this.director);

    void startTurn(State state);
    void place(int x, int y){
        List<List<int>> current = director.state.board1;
        List<List<int>> opposite = director.state.board2;
        if(director.state.currentPlayer == 1){
            current = director.state.board2;
            opposite = director.state.board1;
        }
        current[x][y] = director.state.nextValue;
        print("Placed ${director.state.nextValue} at $x,$y");
        for (var row in opposite) {
            if(row[y] == director.state.nextValue){
                row[y] = 0;
            }
        }
        director.endTurn();
    }



}

class Player extends Actor{
  Player(super.director);

    
    @override
    void startTurn(State state) {
    }

}


class RandomAI extends Actor{
  RandomAI(super.director);

    @override
    void startTurn(State state) {
        int x = Random().nextInt(3);
        int y = Random().nextInt(3);
        while(state.board2[x][y] != 0){
            x = Random().nextInt(3);
            y = Random().nextInt(3);
        }
        place(x,y);
    }
}

class MediumAI extends Actor{
  MediumAI(super.director);

    @override
    void startTurn(State state) {
    }
}

class HardAI extends Actor{
  HardAI(super.director);

    @override
    void startTurn(State state) {
    }
}