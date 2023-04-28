class ExtendedCell {
  int row = 0;
  int column = 0;
  bool isMine = false;
  bool isRevealed = false;
  int value = 0;
  bool isFlagged = false;

  bool forecastIsMine = false;
  int around = 0;
  ExtendedCell(this.row, this.column, this.isMine, this.isRevealed);
}