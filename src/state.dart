

class State{
    late int currentPlayer;
    late List<List<int>> board1;
    late List<List<int>> board2;
    late int nextValue;

    State(){
        currentPlayer = 0;
        board1 = List.generate(3, (i) => List.generate(3,(j)=>0,growable: false),growable: false);
        board2 = List.generate(3, (i) => List.generate(3,(j)=>0,growable: false),growable: false);
        nextValue = 0;
    }
}