import 'dart:math';
import 'actors.dart';
import 'state.dart';
import 'renderer.dart';

class Director{
    late final Renderer _renderer;
    late State state;
    Player? player;
    Actor? ai;

    Director(this._renderer){
        state = State();
    }
    
    void showMenu(){
        _renderer.renderMenu();
    }

    void startGame(String difficulty)async {
        state = State();
        player = Player(this);
        switch(difficulty){
            case "easy":
                ai = RandomAI(this);
                break;
            case "medium":
                ai = MediumAI(this);
                break;
            case "hard":
                ai = HardAI(this);
                break;
        }
        state.currentPlayer = Random().nextInt(2);
        _renderer.renderGame(state);
        state.nextValue = _rollNextValue();
        await _renderer.rollDice(state.currentPlayer,state.nextValue);
        if(state.currentPlayer == 0){
            player?.startTurn(state);
        }
        else{
            ai?.startTurn(state);
        }
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


    void _nextTurn() async {
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
        var score1 = _calculateScore(state.board1);
        var score2 = _calculateScore(state.board2);
        if(score1 > score2){
            _renderer.renderWin();
        }
        else if(score2 > score1){
            _renderer.renderLose();
        }
        else{
            _renderer.renderDraw();
        }
    }

    int _calculateScore(List<List<int>> values){
        var score = 0;
        //TODO multiply columns when containing multiple of same number, then sum all values;
        return score;
    }

    int _rollNextValue(){
        var v = Random().nextInt(6) + 1;
        return v;
    }


}


