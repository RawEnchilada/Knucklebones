

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

    int getColumnScore(List<List<int>> board, int column){
        var sum = 0;
        for(var y = 0;y < 3;y++){
            for(var y2 = 0;y2 < 3;y2++){
                if(y == y2)continue;
                if(board[y][column] == board[y2][column]){
                    sum += board[y][column];
                }
            }
            sum += board[y][column];
        }
        return sum;
    }

    int getTotalScore(List<List<int>> board){
        var sum = 0;
        for(int i = 0; i < 3; i++){
            sum += getColumnScore(board,i);
        }
        return sum;
    }

    State copy(){
        var state = State();
        state.currentPlayer = currentPlayer;
        state.board1 = List.generate(3, (i) => List.generate(3,(j)=>board1[i][j],growable: false),growable: false);
        state.board2 = List.generate(3, (i) => List.generate(3,(j)=>board2[i][j],growable: false),growable: false);
        state.nextValue = nextValue;
        return state;
    }
}