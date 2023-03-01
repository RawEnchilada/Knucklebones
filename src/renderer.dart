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
        newDisplay.id = "display";
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
        //dropdown.append(OptionElement(data: "Hard", value: "hard"));
        menu.append(dropdown);
        menu.append(ButtonElement()..text = "Start Game"..onClick.listen((e) => _controller.startGame(dropdown.value!)));
        d.append(menu);
        _render(d);
    }

    void renderGame(State state){
        var d = Element.div();
        d.append(_createBoard(1,state));
        for(var i = 0;i < 3;i++){
            var field = Element.div();
            field.id = "indicator0$i";
            field.text = state.getColumnScore(state.board1,i).toString();
            d.append(field);
        }
        d.append(Element.div()..className="field"..id="roll0");
        d.append(Element.div()..className="score"..id="score0"..text=state.getTotalScore(state.board1).toString());
        d.append(Element.div()..className="field"..id="roll1");
        d.append(Element.div()..className="score"..id="score1"..text=state.getTotalScore(state.board2).toString());
        d.append(_createBoard(0, state));
        for(var i = 0;i < 3;i++){
            var field = Element.div();
            field.id = "indicator1$i";
            field.text = state.getColumnScore(state.board2,i).toString();
            d.append(field);
        }
        d.append(Element.div()..id="turnLabel"..text = state.currentPlayer==1?"Your turn":"AI's turn");

        //querySelector("#roll0")?.style.content = state.getTotalScore(state.board1).toString();
        //querySelector("#roll1")?.style.content = state.getTotalScore(state.board2).toString();
        _render(d);
    }
    

    Element _createBoard(int player,State state){
        var values = player == 0?state.board1:state.board2;
        var board = Element.div();
        board.id = "board$player";
        board.className = "board";
        List<Element> elements = [];
        for(var x = 0;x < 3;x++){
            for(var y = 0;y < 3;y++){
                var field = Element.div();
                field.className = "field";
                if(player == 0){
                    field.onClick.listen((e) => _controller.fieldClicked(x,y));
                }
                field.append(_createDice(values[x][y]));
                if(player == 0){
                    elements.add(field);
                }
                else{
                    board.append(field);
                }
            }
        }
        if(elements.isNotEmpty){
            for(var e in elements){
                board.append(e);
            }
        }
        
        return board;
    }

    Element _createDice(int value){
        var dice = Element.div();
        dice.classes = ["dice","dice$value"];
        for (var i = 0; i < value; i++) {
            dice.append(Element.div()..className="dot");
        }
        return dice;
    }

    Future<void> rollDice(int player,int value) async {
        var slot = querySelector("#roll$player");
        if(slot == null)errorReport("Could not find roll slot for player $player");

        //TODO animate
        var dice = _createDice(value);
        querySelector("#roll$player")?.children.clear();
        slot!.append(dice);
        await Future.delayed(Duration(seconds: 1));
    }

    void emptyRollSlots(){
        querySelector("#roll0")?.children.clear();
        querySelector("#roll0")?.append(_createDice(0));
        querySelector("#roll1")?.children.clear();
        querySelector("#roll1")?.append(_createDice(0));
    }

    void errorReport(String text){
        _display = Element.tag("div");
        _display.id = "display";
        _display.text = text;
        document.body?.append(_display);
    }

    Future<void> renderEnd(String label) async {
        _controller.active = false;
        querySelector("#turnLabel")?.text = label;
        await Future.delayed(Duration(seconds: 1));
        document.addEventListener("click", _backToMenu);
    }

    void _backToMenu(Event e) {
        document.removeEventListener("click", _backToMenu);
        _controller.active = true;
        _controller.showMenu();
    }

}