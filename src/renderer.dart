import 'dart:html';
import 'controller.dart';
import 'state.dart';

class Renderer{

    late Element _display;
    final Controller _controller;

    Renderer(this._controller){
        var e = querySelector("#display");
        if(e != null){
            _display = e;
        }
        else{
            errorReport("Could not find display element");
        }
    }

    void _render(Element newDisplay){
        newDisplay.id = "#display";
        _display.replaceWith(newDisplay);
        _display = newDisplay;
    }

    void renderMenu(){
        var d = Element.div();
        var menu = Element.div();
        menu.className = "menu";
        menu.append(HeadingElement.h1()..text = "Knucklebones");
        menu.append(Element.div()..text = "Choose Difficulty");
        var dropdown = SelectElement();
        dropdown.append(OptionElement(data: "Easy", value: "easy"));
        dropdown.append(OptionElement(data: "Medium", value: "medium"));
        dropdown.append(OptionElement(data: "Hard", value: "hard"));
        menu.append(dropdown);
        menu.append(ButtonElement()..text = "Start Game"..onClick.listen((e) => _controller.startGame(dropdown.value!)));
        d.append(menu);
        _render(d);
    }

    void renderGame(State state){
        var d = Element.div();
        var split = Element.div()..className="horizontalSplit";
        var upper = Element.div();
        upper.append(_createBoard(1,state.board2));
        upper.append(Element.div()..className="field"..id="roll1");
        var lower = Element.div();
        lower.append(Element.div()..className="field"..id="roll0");
        lower.append(_createBoard(0, state.board1));
        split.append(upper);
        split.append(lower);
        d.append(split);
        _render(d);
    }
    

    Element _createBoard(int player,List<List<int>> values){
        var board = Element.div();
        var sums = List.generate(3, (index) => 0,growable: false);
        board.id = "board$player";
        board.className = "board";
        for(var x = 0;x < 3;x++){
            for(var y = 0;y < 3;y++){
                var field = Element.div();
                field.className = "field";
                field.onClick.listen((e) => _controller.fieldClicked(x,y));
                field.append(_createDice(values[x][y]));
                board.append(field);
                sums[y] += values[x][y];
            }
        }
        for(var i = 0;i < 3;i++){
            var field = Element.div();
            field.id = "indicator$i";
            field.text = sums[i].toString();
            board.append(field);
        }
        
        return board;
    }

    Element _createDice(int value){
        return Element.div();
    }

    Future<void> rollDice(int player,int value) async {
        var slot = querySelector("#roll$player");
        if(slot == null)errorReport("Could not find roll slot for player $player");

        //TODO animate
        var dice = _createDice(value);
        slot!.append(dice);
        await Future.delayed(Duration(seconds: 1));
    }

    void emptyRollSlots(){
        querySelector("#roll0")?.children.clear();
        querySelector("#roll1")?.children.clear();
    }

    void errorReport(String text){
            _display = Element.tag("div");
            _display.id = "display";
            _display.text = text;
            document.body?.append(_display);
    }

    void renderWin(){

    }
    void renderLose(){

    }
    void renderDraw(){

    }

}