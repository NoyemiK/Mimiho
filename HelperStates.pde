class ConfirmDialog implements GameState {
  int selection_index = 0;
  String[] options = { "Yes", "No!" };
  String type;
  String message;
  PImage bg_card = loadImage("graphics/title_fileselect.png");
  
  ConfirmDialog ( String t ) {
    type = t;
    switch(type) {
      case "FILE_PERSISTENT":
        message = "Are you sure you want to reset persistent data?";
        break;
      case "FILE_DELETE":
        message = "Are you sure you want to delete this file?";
        break;
    }
  }
  
  void update() {
    image(bg_card, 0, 0);
    text(message, width/2 - 128, 100);
    game.draw_options(options, selection_index, width/2 - 64, 128);
  }
  
  void input(String signal) {
    switch(signal) {
      case "UP":
        input_up();
        break;
      case "DOWN":
        input_down();
        break;
      case "CONFIRM":
        input_confirm();
        break;
      case "CANCEL":
        input_cancel();
        break;
    } 
  }
  
  void input_up() {
    if (selection_index == 0) { selection_index = options.length - 1; }
    else { selection_index--; }
  }
  
  void input_down() {
    if (selection_index == options.length - 1) { selection_index = 0; }
    else { selection_index++; }
  }
  
  void input_confirm() {
    switch (selection_index) {
       case 0:
         perform_action();
         break;
       case 1:
         game.pop_gamestate();
         break;
    }
  }
  
  void input_cancel() {
      game.pop_gamestate();
  }
  
  void perform_action() {
    switch(type) {
      case "FILE_PERSISTENT":
        generate_persistent_data();
        load_persistent_data(game);
        game.pop_gamestate();
        break;
    }
  }
}
