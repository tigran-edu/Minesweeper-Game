import 'dart:collection';

import 'package:course_work/Grid/cell.dart';
import 'dart:math';

enum Complexity { veryEasy, easy, normal, hard, veryHard, death, unreal, test }

class Grid {
  var size = 0;
  List<List<Cell>> cells = [];
  var totalCellsRevealed = 0;
  var totalMines = 0;
  Complexity complexity = Complexity.veryEasy;

  Grid(this.complexity) {
    if (complexity == Complexity.test) {
      size = 10;
      totalMines = 0;
    } else if (complexity == Complexity.veryEasy) {
      size = 5;
      totalMines = 5;
    } else if (complexity == Complexity.easy) {
      size = 5;
      totalMines = 6;
    } else if (complexity == Complexity.normal) {
      size = 6;
      totalMines = 12;
    } else if (complexity == Complexity.hard) {
      size = 7;
      totalMines = 19;
    } else if (complexity == Complexity.veryHard) {
      size = 7;
      totalMines = 25;
    } else if (complexity == Complexity.death) {
      size = 8;
      totalMines = 45;
    } else {
      size = 10;
      totalMines = 90;
    }
  }

  void generateGrid() {
    cells = [];
    totalCellsRevealed = 0;

    for (int row = 0; row < size; row++) {
      List<Cell> currentRow = [];
      for (int column = 0; column < size; column++) {
        final cell = Cell(row, column);
        currentRow.add(cell);
      }
      cells.add(currentRow);
    }
    fillMatrix();
    for (int i = 0; i < cells.length; ++i) {
      for (int j = 0; j < cells[i].length; ++j) {
        if (cells[j][i].isMine) {
          createInitialNumbersAroundMine(cells[j][i]);
        }
      }
    }
  }

  void fillMatrix() {
    var minLeft = totalMines;
    var random = Random();
    for (int i = 0; i < cells.length; ++i) {
      if (minLeft == 0) {
        break;
      }
      for (int j = 0; j < cells[i].length; ++j) {
        if (minLeft == 0) {
          break;
        }
        cells[i][j].isMine = true;
        minLeft -= 1;
      }
    }
    for (int k = 0; k < cells.length / 2; ++k) {
      for (int i = 0; i < cells.length; ++i) {
        for (int j = 0; j < cells[i].length; ++j) {
          var newI = random.nextInt(cells.length - 1);
          var newJ = random.nextInt(cells[i].length - 1);
          var tmp = cells[i][j].isMine;
          cells[i][j].isMine = cells[newI][newJ].isMine;
          cells[newI][newJ].isMine = tmp;
        }
      }
    }
  }

  void createInitialNumbersAroundMine(Cell cell) {
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

  bool checkIfPlayerWon() {
    return totalCellsRevealed + totalMines == size * size;
  }

  void boom() {
    for (int i = 0; i < cells.length; ++i) {
      for (int j = 0; j < cells[i].length; ++j) {
        if (cells[i][j].isMine) {
          cells[i][j].isRevealed = true;
        }
      }
    }
  }

  void openCells(Cell cell) {
    cell.isRevealed = true;
    totalCellsRevealed += 1;
    int xStart = 0;
    int xEnd = 0;
    int yStart = 0;
    int yEnd = 0;
    final queue = ListQueue<Cell>();
    queue.addLast(cell);
    while (queue.isNotEmpty) {
      final currentCell = queue.removeFirst();
      xStart = currentCell.column < 1 ? 0 : (currentCell.column - 1);
      xEnd = (currentCell.column + 1) == size ? (size - 1) : (currentCell.column + 1);
      yStart = currentCell.row < 1 ? 0 : (currentCell.row - 1);
      yEnd = (currentCell.row + 1) == size ? (size - 1) : (currentCell.row + 1);

      for (int i = xStart; i <= xEnd; ++i) {
        for (int j = yStart; j <= yEnd; ++j) {
          if (!cells[j][i].isMine &&
              !cells[j][i].isRevealed &&
              cells[j][i].value == 0) {
            cells[j][i].isRevealed = true;
            totalCellsRevealed += 1;
            queue.addLast(cells[j][i]);
          } else if (!cells[j][i].isMine && !cells[j][i].isRevealed) {
            cells[j][i].isRevealed = true;
            totalCellsRevealed += 1;
          }
        }
      }
    }
  }
}
