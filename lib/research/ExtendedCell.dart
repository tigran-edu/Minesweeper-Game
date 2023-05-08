class ExtendedCell {
  int row = 0;
  int column = 0;
  bool isMine = false;
  bool isRevealed = false;
  int value = 0;

  bool forecastIsMine = false;
  ExtendedCell(this.row, this.column, this.isMine, this.isRevealed, this.value);

  bool isEqual(ExtendedCell cell) {
    return row == cell.row && column == cell.column;
  }
}