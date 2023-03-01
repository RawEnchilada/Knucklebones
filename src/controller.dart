import 'director.dart';

class Controller{

    bool active = true;

    Function? _onStartGame;
    Function? _onFieldClick;
    Function? _onShowMenu;

    void bindDirector(Director director){
        _onStartGame = director.startGame;
        _onFieldClick = director.playerPlaced;
        _onShowMenu = director.showMenu;
        active = true;
    }

    void startGame(String difficulty){
        _onStartGame?.call(difficulty);
    }

    void fieldClicked(int x,int y){
        if(active)_onFieldClick?.call(x,y);
    }

    void showMenu(){
        _onShowMenu?.call();
    }
}