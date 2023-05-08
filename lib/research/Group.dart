import 'package:course_work/research/ExtendedCell.dart';
import 'dart:math';

class Group {
  int size = 0;
  int amountOfMines = 0;
  List<ExtendedCell> group = [];

  void addCell(ExtendedCell cell) {
    group.add(cell);
    size += 1;
  }

  bool isSubset(Group anotherGroup) {
    int counter = 0;
    // переделать в бинпоиск после, не забудь, что матрица транспонированная, то есть нужно считать начала столбец, потом строку)
    for (int i = 0; i < size; ++i) {
      for (int j = 0; j < anotherGroup.size; ++j) {
        if (group[i].isEqual(anotherGroup.group[j])) {
          counter += 1;
          break;
        }
      }
    }
    return size == counter || anotherGroup.size == counter;
  }

  bool isEqual(Group anotherGroup) {
    if (size != anotherGroup.size) {
      return false;
    }
    for (int i = 0; i < size; ++i) {
      if (!group[i].isEqual(anotherGroup.group[i])) {
        return false;
      }
    }
    return true;
  }

  Group intersection(Group anotherGroup) {
    // переделать в бинпоиск после
    Group newGroup = Group();
    newGroup.amountOfMines = -1;
    for (int i = 0; i < size; ++i) {
      for (int j = 0; j < anotherGroup.size; ++j) {
        if (group[i].isEqual(anotherGroup.group[j])) {
          newGroup.addCell(group[i]);
          break;
        }
      }
    }
    // требуются тесты
    int counter = 0;
    for (int i = max(0, amountOfMines - size + newGroup.size); i <= min(newGroup.size, amountOfMines); ++i) {
      if (anotherGroup.amountOfMines >= i && i >= anotherGroup.amountOfMines + newGroup.size - anotherGroup.size) {
        counter += 1;
        newGroup.amountOfMines = i;
      }
    }
    if (counter > 1) {
      newGroup.amountOfMines = -1;
    }
    return newGroup;
  }

  Group deleteSubset(Group subset) {
    Group newGroup = Group();
    newGroup.amountOfMines = amountOfMines - subset.amountOfMines;
    newGroup.size = size - subset.size;
    int j = 0;
    int i = 0;
    while (j < size) {
      if (i >= subset.size || !group[j].isEqual(subset.group[i])) {
        newGroup.group.add(group[j]);
      } else {
        ++i;
      }
      ++j;
    }
    return newGroup;
  }
}