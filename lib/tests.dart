import 'package:saper/research/Group.dart';
import 'package:saper/research/ExtendedCell.dart';
import 'package:saper/grid/grid.dart';
import 'package:saper/grid/cell.dart';

void check(bool result, bool answer) {
  if (result == answer) {
    print('Test passed');
  } else {
    print('Test failed');
  }
}

void groupTest() {
  Group group1 = Group();
  Group group2 = Group();
  group1.amountOfMines = 1;
  group2.amountOfMines = 2;
  ExtendedCell cell1 = ExtendedCell(0, 0, false, false, 0);
  ExtendedCell cell2 = ExtendedCell(1, 1, false, false, 2);
  ExtendedCell cell3 = ExtendedCell(2, 2, true, false, 0);
  ExtendedCell cell4 = ExtendedCell(3, 3, true, false, 0);
  group1.addCell(cell1);
  group1.addCell(cell2);
  group1.addCell(cell3);

  group2.addCell(cell2);
  group2.addCell(cell3);
  group2.addCell(cell4);
  Group group = group1.intersection(group2);
  group1 = group1.deleteSubset(group);
}

void allTest1() {
  Grid grid = Grid(complexity: Complexity.veryEasy.toString().substring(11));
  for (int row = 0; row < grid.size; ++row) {
    List<Cell> currentRow = [];
    for (int col = 0; col < grid.size; ++col) {
      final cell = Cell(row, col);
      currentRow.add(cell);
    }
    grid.cells.add(currentRow);
  }
  grid.cells[0][0].isMine = true;
  grid.cells[0][1].isMine = true;
  grid.cells[2][0].isMine = true;
  grid.cells[3][1].isMine = true;
  grid.cells[3][4].isMine = true;
  grid.updateValuesAroundBomb(grid.cells[0][0]);
  grid.updateValuesAroundBomb(grid.cells[0][1]);
  grid.updateValuesAroundBomb(grid.cells[2][0]);
  grid.updateValuesAroundBomb(grid.cells[3][1]);
  grid.updateValuesAroundBomb(grid.cells[3][4]);
  check(grid.solvable(grid.cells[0][4]), true);
}

void allTest2() {
  Grid grid = Grid(complexity: Complexity.veryEasy.toString().substring(11));
  for (int row = 0; row < grid.size; ++row) {
    List<Cell> currentRow = [];
    for (int col = 0; col < grid.size; ++col) {
      final cell = Cell(row, col);
      currentRow.add(cell);
    }
    grid.cells.add(currentRow);
  }
  grid.cells[1][2].isMine = true;
  grid.cells[1][3].isMine = true;
  grid.cells[1][4].isMine = true;
  grid.cells[4][1].isMine = true;
  grid.cells[3][4].isMine = true;
  grid.updateValuesAroundBomb(grid.cells[1][2]);
  grid.updateValuesAroundBomb(grid.cells[1][3]);
  grid.updateValuesAroundBomb(grid.cells[1][4]);
  grid.updateValuesAroundBomb(grid.cells[4][1]);
  grid.updateValuesAroundBomb(grid.cells[3][4]);
  check(grid.solvable(grid.cells[0][4]), true);
}

void allTest3() {
  Grid grid = Grid(complexity: Complexity.veryEasy.toString().substring(11));
  for (int row = 0; row < grid.size; ++row) {
    List<Cell> currentRow = [];
    for (int col = 0; col < grid.size; ++col) {
      final cell = Cell(row, col);
      currentRow.add(cell);
    }
    grid.cells.add(currentRow);
  }
  grid.cells[2][2].isMine = true;
  grid.cells[2][3].isMine = true;
  grid.cells[3][2].isMine = true;
  grid.cells[4][0].isMine = true;
  grid.cells[4][1].isMine = true;
  grid.updateValuesAroundBomb(grid.cells[2][2]);
  grid.updateValuesAroundBomb(grid.cells[2][3]);
  grid.updateValuesAroundBomb(grid.cells[3][2]);
  grid.updateValuesAroundBomb(grid.cells[4][0]);
  grid.updateValuesAroundBomb(grid.cells[4][1]);
  check(grid.solvable(grid.cells[0][4]), true);
}

void allTest4() {
  Grid grid = Grid(complexity: Complexity.normal.toString().substring(11));
  for (int row = 0; row < grid.size; ++row) {
    List<Cell> currentRow = [];
    for (int col = 0; col < grid.size; ++col) {
      final cell = Cell(row, col);
      currentRow.add(cell);
    }
    grid.cells.add(currentRow);
  }
  grid.cells[0][0].isMine = true;
  grid.cells[0][1].isMine = true;
  grid.cells[0][3].isMine = true;
  grid.cells[0][4].isMine = true;
  grid.cells[2][0].isMine = true;
  grid.cells[3][0].isMine = true;
  grid.cells[3][5].isMine = true;
  grid.cells[4][5].isMine = true;
  grid.cells[5][0].isMine = true;
  grid.cells[5][3].isMine = true;
  grid.cells[5][4].isMine = true;
  grid.cells[5][5].isMine = true;
  grid.updateValuesAroundBomb(grid.cells[0][0]);
  grid.updateValuesAroundBomb(grid.cells[0][1]);
  grid.updateValuesAroundBomb(grid.cells[0][3]);
  grid.updateValuesAroundBomb(grid.cells[0][4]);
  grid.updateValuesAroundBomb(grid.cells[2][0]);
  grid.updateValuesAroundBomb(grid.cells[3][0]);
  grid.updateValuesAroundBomb(grid.cells[3][5]);
  grid.updateValuesAroundBomb(grid.cells[4][5]);
  grid.updateValuesAroundBomb(grid.cells[5][0]);
  grid.updateValuesAroundBomb(grid.cells[5][3]);
  grid.updateValuesAroundBomb(grid.cells[5][4]);
  grid.updateValuesAroundBomb(grid.cells[5][5]);
  check(grid.solvable(grid.cells[3][3]), true);
}

void allTest5() {
  Grid grid = Grid(complexity: Complexity.hard.toString().substring(11));
  for (int row = 0; row < grid.size; ++row) {
    List<Cell> currentRow = [];
    for (int col = 0; col < grid.size; ++col) {
      final cell = Cell(row, col);
      currentRow.add(cell);
    }
    grid.cells.add(currentRow);
  }
  grid.cells[0][0].isMine = true;
  grid.cells[0][2].isMine = true;
  grid.cells[0][3].isMine = true;
  grid.cells[0][5].isMine = true;
  grid.cells[0][6].isMine = true;
  grid.cells[1][0].isMine = true;
  grid.cells[1][3].isMine = true;
  grid.cells[1][6].isMine = true;
  grid.cells[2][1].isMine = true;
  grid.cells[2][6].isMine = true;
  grid.cells[3][0].isMine = true;
  grid.cells[3][4].isMine = true;
  grid.cells[3][6].isMine = true;
  grid.cells[4][3].isMine = true;
  grid.cells[4][6].isMine = true;
  grid.cells[5][1].isMine = true;
  grid.cells[5][5].isMine = true;
  grid.cells[6][1].isMine = true;
  grid.cells[6][2].isMine = true;

  grid.updateValuesAroundBomb(grid.cells[0][0]);
  grid.updateValuesAroundBomb(grid.cells[0][2]);
  grid.updateValuesAroundBomb(grid.cells[0][3]);
  grid.updateValuesAroundBomb(grid.cells[0][5]);
  grid.updateValuesAroundBomb(grid.cells[0][6]);
  grid.updateValuesAroundBomb(grid.cells[1][0]);
  grid.updateValuesAroundBomb(grid.cells[1][3]);
  grid.updateValuesAroundBomb(grid.cells[1][6]);
  grid.updateValuesAroundBomb(grid.cells[2][1]);
  grid.updateValuesAroundBomb(grid.cells[2][6]);
  grid.updateValuesAroundBomb(grid.cells[3][0]);
  grid.updateValuesAroundBomb(grid.cells[3][4]);
  grid.updateValuesAroundBomb(grid.cells[3][6]);
  grid.updateValuesAroundBomb(grid.cells[4][3]);
  grid.updateValuesAroundBomb(grid.cells[4][6]);
  grid.updateValuesAroundBomb(grid.cells[5][1]);
  grid.updateValuesAroundBomb(grid.cells[5][5]);
  grid.updateValuesAroundBomb(grid.cells[6][1]);
  grid.updateValuesAroundBomb(grid.cells[6][2]);
  check(grid.solvable(grid.cells[1][1]), true);
}

void allTest6() {
  Grid grid = Grid(complexity: Complexity.veryEasy.toString().substring(11));
  for (int row = 0; row < grid.size; ++row) {
    List<Cell> currentRow = [];
    for (int col = 0; col < grid.size; ++col) {
      final cell = Cell(row, col);
      currentRow.add(cell);
    }
    grid.cells.add(currentRow);
  }
  grid.cells[0][3].isMine = true;
  grid.cells[1][3].isMine = true;
  grid.cells[1][4].isMine = true;
  grid.cells[3][0].isMine = true;
  grid.cells[4][4].isMine = true;

  grid.updateValuesAroundBomb(grid.cells[0][3]);
  grid.updateValuesAroundBomb(grid.cells[1][3]);
  grid.updateValuesAroundBomb(grid.cells[1][4]);
  grid.updateValuesAroundBomb(grid.cells[3][0]);
  grid.updateValuesAroundBomb(grid.cells[4][4]);
  check(grid.solvable(grid.cells[3][2]), false);
}
