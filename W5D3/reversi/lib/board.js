let Piece = require("./piece");

/**
 * Returns a 2D array (8 by 8) with two black pieces at [3, 4] and [4, 3]
 * and two white pieces at [3, 3] and [4, 4]
 */
function _makeGrid () {
  let rows = [];
  for (let rowCount=0; rowCount < 8; rowCount++) {
      rows[rowCount] = [];
      for (let colCount=0; colCount < 8; colCount++) {
          rows[rowCount][colCount] = null;
      }
  }

  rows[3][4] = new Piece("black");
  rows[4][3] = new Piece("black");
  rows[3][3] = new Piece("white");
  rows[4][4] = new Piece("white");

  return rows;
}

/**
 * Constructs a Board with a starting grid set up.
 */
function Board () {
  this.grid = _makeGrid();
}

Board.DIRS = [
  [ 0,  1], [ 1,  1], [ 1,  0],
  [ 1, -1], [ 0, -1], [-1, -1],
  [-1,  0], [-1,  1]
];

/**
 * Returns the piece at a given [x, y] position,
 * throwing an Error if the position is invalid.
 */
Board.prototype.getPiece = function (pos) {
  if (this.isOccupied(pos)) {
    return this.grid[pos[0]][pos[1]];
  } else {
    return;
  }
};

/**
 * Checks if there are any valid moves for the given color.
 */
Board.prototype.hasMove = function (color) {
  return this.validMoves(color).length > 0;
};

/**
 * Checks if the piece at a given position
 * matches a given color.
 */
Board.prototype.isMine = function (pos, color) {
  if (this.getPiece(pos)) {
    return this.getPiece(pos).color === color;
  }
  return;
};

/**
 * Checks if a given position has a piece on it.
 */
Board.prototype.isOccupied = function (pos) {
  return this.grid[pos[0]][pos[1]] instanceof Piece;
};

/**
 * Checks if both the white player and
 * the black player are out of moves.
 */
Board.prototype.isOver = function () {
  return !this.hasMove("white") && !this.hasMove("black");
};

/**
 * Checks if a given position is on the Board.
 */
Board.prototype.isValidPos = function (pos) {
  let x = (pos[0] >= 0 && pos[0] < 8);
  let y = (pos[1] >= 0 && pos[1] < 8);
  return x && y;
};

/**
 * Recursively follows a direction away from a starting position, adding each
 * piece of the opposite color until hitting another piece of the current color.
 * It then returns an array of all pieces between the starting position and
 * ending position.
 *
 * Returns null if it reaches the end of the board before finding another piece
 * of the same color.
 *
 * Returns null if it hits an empty position.
 *
 * Returns null if no pieces of the opposite color are found.
 */
function _positionsToFlip (board, pos, color, dir, piecesToFlip) {
  let current = (board.grid[pos[0]][pos[1]]);
  if (current === null || current.color === color) {
    return;
  } else {
    let newPos = [pos[0] + dir[0], pos[1] + dir[1]];
    piecesToFlip.push(pos);
    _positionsToFlip(board, newPos, color, dir, piecesToFlip);
  }
  return piecesToFlip;
}

/**
 * Adds a new piece of the given color to the given position, flipping the
 * color of any pieces that are eligible for flipping.
 *
 * Throws an error if the position represents an invalid move.
 */
Board.prototype.placePiece = function (pos, color) {
  let flippablePieces = [];
  if (!this.validMove(pos, color)) {
    throw "Invalid move";
  }
  this.DIRS.forEach(function(dir){
    flippablePieces.concat(_positionsToFlip(this, pos, color, dir, []));
  });

  flippablePieces.forEach(function(p){
    this.grid[p[0]][p[1]].flip;
  });
};

/**
 * Prints a string representation of the Board to the console.
 */
Board.prototype.print = function () {
  this.grid.forEach(function(row){
    let str = "";
    row.forEach(function(el){
      if (el instanceof Piece) {
        str += el.toString();
      } else {
        str += "_";
      }
    });
    console.log(str);
  });
};

/**
 * Checks that a position is not already occupied and that the color
 * taking the position will result in some pieces of the opposite
 * color being flipped.
 */
Board.prototype.validMove = function (pos, color) {
  let flippablePieces = [];
  this.DIRS.forEach(function(dir){
    flippablePieces.concat(_positionsToFlip(this, pos, color, dir, []));
  });

  return (this.grid[pos[0]][pos[1]] === null && flippablePieces.length > 0);
};

/**
 * Produces an array of all valid positions on
 * the Board for a given color.
 */
Board.prototype.validMoves = function (color) {
  let results = [];
  for (let i = 0; i < 8; i++) {
    for (let j = 0; j < 8; j++) {
      if (this.validMove([i,j], color)) {
        results.push([i,j]);
      }
    }
  }
  return results;
};

module.exports = Board;
