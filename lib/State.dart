import 'package:flutter/material.dart';
import 'package:course_work/Grid/cell.dart';
import 'package:course_work/Grid/Grid.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minesweeper Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var grid = Grid(Complexity.test);

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
    if (cell.isRevealed) {
      return;
    }
    cell.isFlagged = !cell.isFlagged;
    setState(() {});
  }

  void onTap(Cell cell) async {
    if (cell.isMine && grid.totalCellsRevealed == 0) {
      while (grid.cells[cell.row][cell.column].isMine == true || !grid.solvable()) {
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
          title: Text("Game Over"),
          content: Text("Bomb has been exploded!"),
          actions: [
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Restart"),
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
            title: Text("Congratulations"),
            content: Text(
                "You solved ${grid.complexity.name} level. Tap the button to solve next one."),
            actions: [
              MaterialButton(
                color: Colors.blue[300],
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Next"),
              ),
            ],
          ),
        );
        if (response1 == null) {
          restart();
        } else if (response1) {
          if (grid.complexity.index != 7) {
            grid.complexity = Complexity.values[grid.complexity.index + 1];
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
  }

  @override
  void initState() {
    super.initState();
    grid.generateGrid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Minesweeper"),
      ),
      body: Container(
        margin: const EdgeInsets.all(1.0),
        child: buildButtonColumn(),
      ),
    );
  }
}
