import 'package:flutter/material.dart';
import 'package:course_work/Grid/cell.dart';
import 'package:course_work/Grid/Grid.dart';

void main() {
  runApp(MyApp());
}

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
  var grid = Grid(Complexity.easy);


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
        LinearProgressIndicator(
          backgroundColor: Colors.white,
          value: grid.totalCellsRevealed / (grid.size * grid.size - grid.totalMines),
          valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
        ),
      ],
    );
  }

  void markFlagged(Cell cell) {
    cell.isFlagged = !cell.isFlagged;
    setState(() {});
  }

  void onTap(Cell cell) async {
    if (cell.isMine && grid.totalCellsRevealed == 0) {
      while (grid.cells[cell.row][cell.column].isMine == true) {
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
          content: Text("You stepped on a mine. Be careful next time."),
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
        final response = await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Congratulations"),
            content: Text("You discovered all the tiles without stepping on any mines. Well done."),
            actions: [
              MaterialButton(
                color: Colors.deepPurple,
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Next Level"),
              ),
            ],
          ),
        );

        if (response) {
          grid.size++;
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
        backgroundColor: Colors.deepPurple,
        title: Text("Minesweeper"),
        actions: [
          IconButton(
            icon: Icon(Icons.fiber_new),
            onPressed: () => restart(),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(1.0),
        child: buildButtonColumn(),
      ),
    );
  }
}