import 'director.dart';

class Controller{

    Function? _onStartGame;
    Function? _onFieldClick;

    void bindDirector(Director director){
        _onStartGame = director.startGame;
        _onFieldClick = director.playerPlaced;
    }

    void startGame(String difficulty){
        _onStartGame?.call(difficulty);
    }

    void fieldClicked(int x,int y){
        _onFieldClick?.call(x,y);
    }
}