import 'dart:math';
import 'dart:typed_data';
import 'director.dart';
import 'state.dart';
//import 'package:eneural_net/eneural_net.dart';
//import 'package:eneural_net/eneural_net_extensions.dart';

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
    void startTurn(State state) {}

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

class MinMaxAI extends Actor{
    MinMaxAI(super.director);

    @override
    void startTurn(State state) {
        var stateClone = state.copy();


        int maxScore = -1000;
        int mx = 0;
        int my = 0;
        for (var x = 0; x < 3; x++) {
            for (var y = 0; y < 3; y++) {
                if(stateClone.board2[x][y] == 0){
                    mx = x;
                    my = y;
                    break;
                }
            }
        }

        for (var x = 0; x < 3; x++) {
            for (var y = 0; y < 3; y++) {
                if(stateClone.board2[x][y] == 0){
                    stateClone.board2[x][y] = state.nextValue;
                    int myScore = stateClone.getTotalScore(stateClone.board2);
                    int enemyScore = stateClone.getTotalScore(stateClone.board1);
                    int score = myScore - enemyScore;
                    if(score > maxScore){
                        maxScore = score;
                        mx = x;
                        my = y;
                    }
                    stateClone.board2[x][y] = 0;
                }
            }
        }
        place(mx,my);       
    }


}

class LearningAI extends Actor{

    //late ANN _ann;

    LearningAI(super.director){
        /*var activationFunction = ActivationFunctionSigmoid();
        _ann = ANN<double, Float32x4, SignalFloat32x4, Scale<double>>(
            ScaleDouble.ZERO_TO_ONE,
            LayerFloat32x4(19, true, ActivationFunctionLinear()), // 2x 3x3 boards + 1 next value
            [HiddenLayerConfig(25, true, activationFunction),
             HiddenLayerConfig(25, true, activationFunction)], // hidden layers
            LayerFloat32x4(9, false, activationFunction) // 9 possible slots
        );*/
    }

    @override
    void startTurn(State state) {
        

    }
}

class TrainedAI extends Actor{

    //late ANN _ann;

    TrainedAI(super.director){
        //_ann load trained model
    }

    @override
    void startTurn(State state) {
        

    }
}