import 'dart:collection';

import 'package:course_work/research/ExtendedCell.dart';
import 'package:course_work/Grid/Grid.dart';

class ExtendedGrid {
  var size = 0;
  List<List<ExtendedCell>> cells = [];
  var totalCellsRevealed = 0;
  var totalMines = 0;

  ExtendedGrid(Grid grid) {
    totalMines = grid.totalMines;
    size = grid.size;
    totalCellsRevealed = grid.totalCellsRevealed;
    for (int i = 0; i < size; ++i) {
      List<ExtendedCell> currentRow = [];
      for (int j = 0; j < size; ++j) {
        final cell = ExtendedCell(grid.cells[i][j].row, grid.cells[i][j].column,
            grid.cells[i][j].isMine, grid.cells[i][j].isRevealed);
        currentRow.add(cell);
      }
      cells.add(currentRow);
    }
  }

  void updateValuesAroundBomb(ExtendedCell cell) {
    int xStart = cell.column < 1 ? 0 : (cell.column - 1);
    int xEnd = cell.column + 1 == size ? (size - 1) : (cell.column + 1);

    int yStart = cell.row < 1 ? 0 : (cell.row - 1);
    int yEnd = (cell.row + 1) == size ? (size - 1) : (cell.row + 1);

    for (int i = xStart; i <= xEnd; ++i) {
      for (int j = yStart; j <= yEnd; ++j) {
        if (!cells[j][i].isMine) {
          cells[j][i].value++;
        }
      }
    }
  }

  void openCells(ExtendedCell cell) {
    cell.isRevealed = true;
    totalCellsRevealed += 1;
    int columnStart = 0;
    int columnEnd = 0;
    int rowStart = 0;
    int rowEnd = 0;
    final queue = ListQueue<ExtendedCell>();
    queue.addLast(cell);
    while (queue.isNotEmpty) {
      final currentCell = queue.removeFirst();
      columnStart = currentCell.column < 1 ? 0 : (currentCell.column - 1);
      columnEnd = (currentCell.column + 1) == size
          ? (size - 1)
          : (currentCell.column + 1);
      rowStart = currentCell.row < 1 ? 0 : (currentCell.row - 1);
      rowEnd =
      (currentCell.row + 1) == size ? (size - 1) : (currentCell.row + 1);

      for (int i = rowStart; i <= rowEnd; ++i) {
        for (int j = columnStart; j <= columnEnd; ++j) {
          if (!cells[i][j].isMine &&
              !cells[i][j].isRevealed &&
              cells[i][j].value == 0) {
            cells[i][j].isRevealed = true;
            totalCellsRevealed += 1;
            queue.addLast(cells[i][j]);
          } else if (!cells[i][j].isMine && !cells[i][j].isRevealed) {
            cells[i][j].isRevealed = true;
            totalCellsRevealed += 1;
          }
        }
      }
    }
  }

  bool solvable() {
    return true;
  }
}
