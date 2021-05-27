import 'model.dart';

abstract class DatabaseEvent {
  Model onRead(Model model){

    return model;
  }

  Model onCreate(Model model){

    return model;
  }

  Model onDelete(Model model){

    return model;
  }

  Model onUpdate(Model model){

    return model;
  }

}