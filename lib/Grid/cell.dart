import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cell {
  int row = 0;
  int column = 0;
  bool isMine = false;
  bool isRevealed = false;
  int value = 0;
  bool isFlagged = false;

  Cell(this.row, this.column);
}
