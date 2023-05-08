import 'dart:collection';

import 'package:course_work/research/ExtendedCell.dart';
import 'package:course_work/Grid/Grid.dart';
import 'package:course_work/research/Group.dart';

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
            grid.cells[i][j].isMine, grid.cells[i][j].isRevealed, grid.cells[i][j].value);
        currentRow.add(cell);
      }
      cells.add(currentRow);
    }
  }

  Group createGroup(ExtendedCell cell) {
    Group newGroup = Group();
    newGroup.amountOfMines = cell.value;
    List<int> limits = takeLimits(cell);
    int columnStart = limits[0];
    int columnEnd = limits[1];
    int rowStart = limits[2];
    int rowEnd = limits[3];

    for (int row = rowStart; row <= rowEnd; ++row) {
      for (int col = columnStart; col <= columnEnd; ++col) {
        if (cells[row][col].forecastIsMine) {
          newGroup.amountOfMines -= 1;
        } else if (!cells[row][col].isRevealed) {
          newGroup.addCell(cells[row][col]);
        }
      }
    }
    return newGroup;
  }

  bool checkIfPlayerWon() {
    return totalCellsRevealed + totalMines == size * size;
  }

  List<int> takeLimits(ExtendedCell cell) {
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

  void updateValuesAroundBomb(ExtendedCell cell) {
    List<int> limits = takeLimits(cell);
    int columnStart = limits[0];
    int columnEnd = limits[1];
    int rowStart = limits[2];
    int rowEnd = limits[3];

    for (int i = rowStart; i <= rowEnd; ++i) {
      for (int j = columnStart; j <= columnEnd; ++j) {
        if (!cells[i][j].isMine) {
          cells[i][j].value++;
        }
      }
    }
  }

  void createGroups(List<Group> groups) {
    for (int row = 0; row < size; ++row) {
      for (int col = 0; col < size; ++col) {
        if (cells[row][col].isRevealed) {
          Group group = createGroup(cells[row][col]);
          if (group.size != 0) {
            groups.add(group);
          }
        }
      }
    }
  }


  void openCells(ExtendedCell cell) {
    if (cell.isRevealed || cell.forecastIsMine) {
      return;
    }
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
      List<int> limits = takeLimits(currentCell);
      columnStart = limits[0];
      columnEnd = limits[1];
      rowStart = limits[2];
      rowEnd = limits[3];

      for (int i = rowStart; i <= rowEnd; ++i) {
        for (int j = columnStart; j <= columnEnd; ++j) {
          if (!cells[i][j].isMine &&
              !cells[i][j].isRevealed &&
              !cells[i][j].forecastIsMine &&
              cells[i][j].value == 0) {
            cells[i][j].isRevealed = true;
            totalCellsRevealed += 1;
            queue.addLast(cells[i][j]);
          } else if (!cells[i][j].isMine && !cells[i][j].forecastIsMine && !cells[i][j].isRevealed) {
            cells[i][j].isRevealed = true;
            totalCellsRevealed += 1;
          }
        }
      }
    }
  }

  bool iteration() {
    bool flag = false;
    bool changes = true;
    List<Group> groups = [];
    createGroups(groups);
    while (changes) {
      changes = false;
      for (int i = 0; i < groups.length; ++i) {
        for (int j = i + 1; j < groups.length; ++j) {
          if (groups[i].isEqual(groups[j])) {
            groups[j] = groups.last;
            groups.removeLast();
            changes = true;
          } else if (groups[i].isSubset(groups[j])) {
            changes = true;
            if (groups[i].size < groups[j].size) {
              groups[j] = groups[j].deleteSubset(groups[i]);
            } else {
              groups[i] = groups[i].deleteSubset(groups[j]);
            }
          } else {
            Group group = groups[i].intersection(groups[j]);
            if (group.size != 0 && group.amountOfMines != -1) {
              changes = true;
              groups[j] = groups[j].deleteSubset(group);
              groups[i] = groups[i].deleteSubset(group);
              groups.add(group);
            }
          }
        }
      }
    }
    for (int i = 0; i < groups.length; ++i) {
      if (groups[i].amountOfMines == groups[i].size) {
        flag = true;
        for (int j = 0; j < groups[i].size; ++j) {
          cells[groups[i].group[j].row][groups[i].group[j].column].forecastIsMine = true;
        }
      } else if (groups[i].amountOfMines == 0) {
        flag = true;
        for (int j = 0; j < groups[i].size; ++j) {
          openCells(groups[i].group[j]);
        }
      }
    }
    return flag;
  }

  bool solvable() {
    while (iteration()) {}
    return checkIfPlayerWon();
  }
}
