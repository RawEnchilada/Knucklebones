import 'dart:math';
import 'actors.dart';
import 'director.dart';
import 'state.dart';

class LearningDirector implements Director{
    @override
    Actor? ai;

    @override
    Actor? player;

    @override
    late State state;

    LearningDirector(){
        state = State();
    }

    @override
    void endTurn() {
        // TODO: implement endTurn
    }

    @override
    void playerPlaced(int x, int y) {
        // TODO: implement playerPlaced
    }

    @override
    void showMenu() {
        // TODO: implement showMenu
    }

    @override
    Future<void> startGame(String difficulty) async {
        player = LearningAI(this);
        ai = RandomAI(this);
    }

}