import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../stuffs/providers/theme_provider.dart';
class Cell {
  int row = 0;
  int column = 0;
  bool isMine = false;
  bool isRevealed = false;
  int value = 0;
  bool isFlagged = false;
  int kFontSize = 12;

  Cell(this.row, this.column);
}

class CellWidget extends StatefulWidget {
  const CellWidget({
    Key? key,
    required this.size,
    required this.cell,
  }) : super(key: key);

  final int size;
  final Cell cell;

  @override
  CellWidgetState createState() => CellWidgetState();
}

class CellWidgetState extends State<CellWidget> {
  @override
  Widget build(BuildContext context) {
    Color themeColor = Provider.of<ThemeProvider>(context).themeColor;
    return Container(
      margin: const EdgeInsets.only(right: 1, bottom: 1),
      height: MediaQuery.of(context).size.width / widget.size + 1,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: widget.cell.isRevealed
            ? (widget.cell.isMine
            ? Colors.red[100]
            : Colors.grey[200 + (widget.cell.value * 50)])
            : themeColor,
      ),
      child: (widget.cell.isMine && widget.cell.isRevealed)
          ? const Center(
        child: Icon(
          Icons.clear,
          color: Colors.red,
        ),
      )
          : widget.cell.isFlagged
          ? Center(
        child: Icon(
          Icons.flag,
          color: Colors.red[400],
          size: 1.5 * widget.cell.kFontSize.toDouble(),
        ),
      )
          : widget.cell.isRevealed
          ? Center(
        child: Text(
          widget.cell.value.toString(),
          style: GoogleFonts.robotoMono(
            fontWeight: FontWeight.w700,
            fontSize: widget.cell.kFontSize.toDouble(),
          ),
        ),
      )
          : Container(),
    );
  }
}
