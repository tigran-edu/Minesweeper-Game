// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saper/stuffs/providers/flag_provider.dart';
import 'package:saper/stuffs/constants.dart';

import 'grid/cell.dart';
import 'grid/grid.dart';


class SaperGrid extends StatefulWidget {
  const SaperGrid({super.key, required this.complexity});

  final String complexity;

  @override
  SaperGridState createState() => SaperGridState();
}

class SaperGridState extends State<SaperGrid> {
  // ignore: prefer_typing_uninitialized_variables
  late var grid;

  @override
  void initState() {
    super.initState();
    grid = Grid(complexity: widget.complexity);
    FlagProvider().flagInit(grid.totalMines);
    grid.generateGrid();
  }

  Widget buildButton(Cell cell) {
    return GestureDetector(
      onLongPress: () {
        markFlagged(cell);
      },
      onTap: () {
        onTap(cell);
      },
      child: CellWidget(
        size: grid.size,
        cell: cell,
      ),
    );
  }

  Row buildButtonRow(int column) {
    List<Widget> list = [];

    for (int i = 0; i < grid.size; i++) {
      list.add(
        Expanded(
          child: buildButton(grid.cells[i][column]),
        ),
      );
    }

    return Row(
      children: list,
    );
  }

  Column buildButtonColumn() {
    List<Widget> rows = [];

    for (int i = 0; i < grid.size; i++) {
      rows.add(
        buildButtonRow(i),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: rows,
        ),
      ],
    );
  }

  void markFlagged(Cell cell) {
    if (cell.isRevealed || (!cell.isFlagged && Provider.of<FlagProvider>(context, listen: false).flagCount == 0)) {
      return;
    }
    if (cell.isFlagged) {
      Provider.of<FlagProvider>(context, listen: false).flagPlus();
    } else {
      Provider.of<FlagProvider>(context, listen: false).flagCount != 0 ? Provider.of<FlagProvider>(context, listen: false).flagMinus() : null;
    }
    Provider.of<FlagProvider>(context, listen: false).flagCount != -1 ? (cell.isFlagged = !cell.isFlagged) : null;
  }

  void onTap(Cell cell) async {
    if (grid.totalCellsRevealed == 0) {
      while (grid.cells[cell.row][cell.column].isMine || !grid.solvable(grid.cells[cell.row][cell.column])) {
        restart();
      }
      cell = grid.cells[cell.row][cell.column];
    }
    if (cell.isMine) {
      grid.boom();
      setState(() {});
      final response = await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Game Over"),
          content: const Text("Bomb has been exploded!"),
          actions: [
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Restart"),
            ),
          ],
        ),
      );

      if (response) {
        restart();
      }
      return;
    } else {
      grid.openCells(cell);
      setState(() {});
      if (grid.checkIfPlayerWon()) {
        final response1 = await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Congratulations"),
            content: Text(
                "You solved ${grid.complexity} level. Tap the button to solve next one."),
            actions: [
              MaterialButton(
                color: Colors.blue[300],
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Next"),
              ),
            ],
          ),
        );
        if (response1 == null) {
          restart();
        } else if (response1) {
          if (grid.complexity != 'ultra') {
            grid.complexity = complexityList[complexityList.indexOf(grid.complexity) + 1];
          }
          restart();
        }
      } else {
        setState(() {});
      }
    }
  }

  void restart() {
    setState(() {
      grid.generateGrid();
    });
    FlagProvider().flagInit(grid.totalMines);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      child: buildButtonColumn(),
    );
  }
}
