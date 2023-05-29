import 'grid.dart';

void openMine(Grid grid) {
  for (int row = 0; row < grid.cells.length; ++row) {
    for (int col = 0; col < grid.cells.length; ++col) {
      if (grid.cells[col][row].isMine && !grid.cells[col][row].isFlagged) {
        grid.cells[col][row].isRevealed = true;
        break;
      }
    }
  }
}