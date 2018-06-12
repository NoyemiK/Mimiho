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
