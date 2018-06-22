  //=======================================================//
// This section generates and converts progression tables.   //
//    You can tweak this formula to get the curves you want, //
//    then dial in fine-tunings in the resulting CSV for     //
//==  balancing the game to your taste (or for modding).   ==//
  //=======================================================//
void gen_progression_table() {
  Table t = new Table();
  String[] columns = {
    "EXP", "MHP", "MAP", "STR", "SPD"
  };
  for ( int i = 0; i < 5; i++) {
    t.addColumn(columns[i], Table.INT);
  }
  TableRow[] rows = new TableRow[10];
  for ( int i = 0; i < 10; i++ ) {
    rows[i] = t.addRow();
    rows[i].setInt("EXP", 0x0020 * (0x0003 * (i*i)));
    rows[i].setInt("MHP", 0x0010 + (0x0004 * floor(i * i/2)) + i);
    rows[i].setInt("MAP", 0x0008 + (0x0002 * i));
    rows[i].setInt("STR", 0x0005 + + floor(i * 3.75) + i);
    rows[i].setInt("SPD", 0x0001 + floor(i/3));
  }
  saveTable(t, "data/base_progression.csv", "csv");
}

void convert_progression_table(String name) {
  Table t = loadTable(name + ".csv", "header, csv");
  int i = 1;
  for ( TableRow row : t.rows() ) {
    int exp = row.getInt("EXP");
    int mhp = row.getInt("MHP");
    int map = row.getInt("MAP");
    int str = row.getInt("STR");
    int spd = row.getInt("SPD");
    println("LVL" + i + " - EXP: " + exp + "| MHP :" + mhp + "| MAP: " + map + "| STR: " + str + "| SPD: " + spd);
    i++;
  }
  saveTable(t, name + ".bun2", "bin");
  println("Converted " + name + ".csv to: " + name + ".bun2");
}

class DebugMenu implements GameState {
  int selection_index = 0;
  String[] options = {
    "Unlock all Outfits", "Unlock all Mapsets",
    "Set tokencount to 255", "Generate a progression table"
  };
  
  DebugMenu () {
    
  }
  
  void update() {
    game.draw_options(options, selection_index, width/2 - 96, 128);
  }
  
  void input(String signal) {
    switch (signal) {
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
         break;
       case 1:
         break;
    }
  }
  
  void input_cancel() {
      game.pop_gamestate();
  }
}
