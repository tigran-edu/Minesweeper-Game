// ignore: file_names
import 'dart:collection';
import 'dart:math';
import 'cell.dart';
import 'package:saper/research/ExtendedGrid.dart';

enum Complexity { test, veryEasy, easy, normal, hard, veryHard, death, unreal, ultra }

class Grid {

  var size = 0;
  List<List<Cell>> cells = [];
  var totalCellsRevealed = 0;
  var totalMines = 0;
  String complexity;

  Grid({required this.complexity}) {
    if (complexity == (Complexity.test).toString().substring(11)) {
      size = 10;
      totalMines = 0;
    } else if (complexity == (Complexity.veryEasy).toString().substring(11)) {
      size = 5;
      totalMines = 5;
    } else if (complexity == (Complexity.easy).toString().substring(11)) {
      size = 5;
      totalMines = 6;
    } else if (complexity == (Complexity.normal).toString().substring(11)) {
      size = 6;
      totalMines = 12;
    } else if (complexity == (Complexity.hard).toString().substring(11)) {
      size = 7;
      totalMines = 19;
    } else if (complexity == (Complexity.veryHard).toString().substring(11)) {
      size = 10;
      totalMines = 25;
    } else if (complexity == (Complexity.death).toString().substring(11)) {
      size = 12;
      totalMines = 45;
    } else if (complexity == (Complexity.ultra).toString().substring(11)) {
      size = 25;
      totalMines = 100;
    } else {
      size = 12;
      totalMines = 35;
    }
  }

  void generateGrid() {
    cells = [];
    totalCellsRevealed = 0;

    for (int row = 0; row < size; row++) {
      List<Cell> currentRow = [];
      for (int column = 0; column < size; column++) {
        final cell = Cell(row, column);
        cell.kFontSize = cell.kFontSize * cell.kFontSize ~/ size;
        currentRow.add(cell);
      }
      cells.add(currentRow);
    }
    fillMatrix();
    for (int i = 0; i < cells.length; ++i) {
      for (int j = 0; j < cells[i].length; ++j) {
        if (cells[j][i].isMine) {
          updateValuesAroundBomb(cells[j][i]);
        }
      }
    }
  }
  List<int> takeLimits(Cell cell) {
    List<int> limits = [];
    int columnStart = cell.column < 1 ? 0 : (cell.column - 1);
    int columnEnd = (cell.column + 1) == size ? (size - 1) : (cell.column + 1);
    int rowStart = cell.row < 1 ? 0 : (cell.row - 1);
    int rowEnd = (cell.row + 1) == size ? (size - 1) : (cell.row + 1);
    limits.add(columnStart);
    limits.add(columnEnd);
    limits.add(rowStart);
    limits.add(rowEnd);
    return limits;
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

  void updateValuesAroundBomb(Cell cell) {
    List<int> limits = takeLimits(cell);
    int columnStart = limits[0];
    int columnEnd = limits[1];
    int rowStart = limits[2];
    int rowEnd = limits[3];

    for (int row = rowStart; row <= rowEnd; ++row) {
      for (int col = columnStart; col <= columnEnd; ++col) {
        if (!cells[row][col].isMine) {
          cells[row][col].value++;
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
    if (cell.isFlagged || cell.isRevealed) {
      return;
    }
    cell.isRevealed = true;
    totalCellsRevealed += 1;
    int columnStart = 0;
    int columnEnd = 0;
    int rowStart = 0;
    int rowEnd = 0;
    final queue = ListQueue<Cell>();
    queue.addLast(cell);
    while (queue.isNotEmpty) {
      final currentCell = queue.removeFirst();
      List<int> limits = takeLimits(currentCell);
      columnStart = limits[0];
      columnEnd = limits[1];
      rowStart = limits[2];
      rowEnd = limits[3];
      for (int i = rowStart; i <= rowEnd; ++i) {
        for (int j = columnStart; j <= columnEnd; ++j) {
          if (!cells[i][j].isMine &&
              !cells[i][j].isRevealed &&
              !cells[i][j].isFlagged &&
              cells[i][j].value == 0) {
            cells[i][j].isRevealed = true;
            totalCellsRevealed += 1;
            queue.addLast(cells[i][j]);
          } else if (!cells[i][j].isMine && !cells[i][j].isFlagged && !cells[i][j].isRevealed) {
            cells[i][j].isRevealed = true;
            totalCellsRevealed += 1;
          }
        }
      }
    }
  }

  bool solvable(Cell cell) {
    openCells(cell);
    ExtendedGrid extendedGrid = ExtendedGrid(cells, totalMines, size, totalCellsRevealed);
    return extendedGrid.solvable();
  }
}
