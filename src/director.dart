import 'dart:math';
import 'actors.dart';
import 'state.dart';
import 'renderer.dart';


class Director{
    late final Renderer _renderer;
    late State state;
    Actor? player;
    Actor? ai;

    Director(this._renderer){
        state = State();
    }
    
    void showMenu(){
        _renderer.renderMenu();
    }

    Future<void> startGame(String difficulty)async {
        state = State();
        player = Player(this);
        switch(difficulty){
            case "easy":
                ai = RandomAI(this);
                break;
            case "medium":
                ai = MinMaxAI(this);
                break;
            case "hard":
                ai = TrainedAI(this);
                break;
        }
        state.currentPlayer = Random().nextInt(2);
        _renderer.renderGame(state);
        await _nextTurn();
    }

    void playerPlaced(int x,int y){
        player?.place(x,y);
    }

    void endTurn(){
        _renderer.renderGame(state);
        _renderer.emptyRollSlots();
        if(state.board1.every((row) => row.every((value) => value != 0)) 
        || state.board2.every((row) => row.every((value) => value != 0))){
            _endGame();
        }
        else{
            _nextTurn();
        }
    }


    Future<void> _nextTurn() async {
        state.currentPlayer = (state.currentPlayer + 1) % 2;
        state.nextValue = _rollNextValue();
        await _renderer.rollDice(state.currentPlayer,state.nextValue);
        if(state.currentPlayer == 0){
            player?.startTurn(state);
        }
        else{
            ai?.startTurn(state);
        }
    }

    void _endGame(){
        var score1 = state.getTotalScore(state.board1);
        var score2 = state.getTotalScore(state.board2);
        if(score1 > score2){
            _renderer.renderEnd("You win!\nClick to continue.");
        }
        else if(score2 > score1){
            _renderer.renderEnd("You lose!\nClick to continue.");
        }
        else{
            _renderer.renderEnd("Draw!\nClick to continue.");
        }
    }


    int _rollNextValue(){
        var v = Random().nextInt(6) + 1;
        return v;
    }


}


