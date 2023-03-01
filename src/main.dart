import 'actors.dart';
import 'controller.dart';
import 'director.dart';
import 'learningDirector.dart';
import 'renderer.dart';


void main() {
    Controller controller = Controller();
    Renderer renderer = Renderer(controller);  
    Director director = Director(renderer);
    controller.bindDirector(director);
    controller.showMenu();
}


void trainai(){
    var director = LearningDirector();
}
