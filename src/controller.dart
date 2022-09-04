import 'director.dart';

class Controller{

    Function? _onStartGame;
    Function? _onFieldClick;
    Function? _onShowMenu;

    void bindDirector(Director director){
        _onStartGame = director.startGame;
        _onFieldClick = director.playerPlaced;
        _onShowMenu = director.showMenu;
    }

    void startGame(String difficulty){
        _onStartGame?.call(difficulty);
    }

    void fieldClicked(int x,int y){
        _onFieldClick?.call(x,y);
    }

    void showMenu(){
        _onShowMenu?.call();
    }
}