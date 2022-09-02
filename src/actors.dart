import 'director.dart';
import 'state.dart';

abstract class Actor{
    Director director;
    Actor(this.director);

    void startTurn(State state);
    void place(State state,int x, int y){
        List<List<int>> current = state.board1;
        List<List<int>> opposite = state.board2;
        if(state.currentPlayer == 1){
            current = state.board2;
            opposite = state.board1;
        }
        current[x][y] = state.nextValue;
        for (var row in opposite) {
            if(row[y] == state.nextValue){
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


class EasyAI extends Actor{
  EasyAI(super.director);

    @override
    void startTurn(State state) {
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