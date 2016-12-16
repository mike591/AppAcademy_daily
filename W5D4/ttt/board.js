class Board {
  constructor() {
    this.grid = [
      [null, null, null],
      [null, null, null],
      [null, null, null]
    ];
  }

  isWon() {
    return this.winner() === null ? false : true;
  }

  //checks horizontals, verticals and diagonals for 3 in a row
  winner() {
    return this.checkHorizontals() ||
           this.checkVerticals() ||
           this.checkDiagonals();
  }

  checkHorizontals() {
    let winner = null;
    this.grid.forEach(row => {
      if (row.every(el => el === "o")) {
        winner = "o";
      } else if (row.every(el => el === "x")) {
        winner = "x";
      }
    });
    return winner;
  }

  checkVerticals() {
    const transposed = this.grid[0].map((col, i) => {
      return this.grid.map(function(row) {
        return row[i];
      });
    });

    let winner = null;
    transposed.forEach(row => {
      if (row.every(el => el === "o")) {
        winner = "o";
      } else if (row.every(el => el === "x")) {
        winner = "x";
      }
    });
    return winner;
  }

  checkDiagonals() {
    const diagGrid = [
      [this.grid[0][0], this.grid[1][1], this.grid[2][2]],
      [this.grid[0][2], this.grid[1][1], this.grid[2][0]]
    ];

    let winner = null;
    diagGrid.forEach(row => {
      if (row.every(el => el === "o")) {
        winner = "o";
      } else if (row.every(el => el === "x")) {
        winner = "x";
      }
    });
    return winner;
  }

  isEmpty(pos) {
    let [row, col] = pos;
    if (this.grid[row][col] === null) {
      return true;
    } else {
      return false;
    }
  }

  //place mark if its valid move
  placeMark(pos, mark) {
    if (this.isValidMove(pos)) {
      let [row, col] = pos;
      this.grid[row][col] = mark;
      return true;
    } else {
      return false;
    }
  }

  //check for input type and that its inside board
  // if its empty
  isValidMove(pos) {
    let [row, col] = pos;
    if (isNaN(row) || isNaN(col)) {
      return false;
    } else if (row < 0 || row > 2 || col < 0 || col > 2 ) {
      return false;
    } else if (this.isEmpty(pos)) {
      return true;
    } else {
      return false;
    }
  }

  emptyPos() {
    let empty = [];
    for (let i = 0; i < this.grid.length; i++) {
      for (let j = 0; j < this.grid[0].length; j++) {
        if (this.isEmpty([i,j])) {
          empty.push([i,j]);
        }
      }
    }
    return empty;
  }

  render() {
    this.grid.forEach(row => {
      let r = row.map(el => el === null ? '-' : el);
      console.log(r);
    });
  }
}
//
// let board = new Board;
// board.grid = [ ["x", null, null], [null, "x", null], [null, null, "x"] ];
// // console.log(board.checkDiagonals());
// console.log(board.placeMark([0,1], 'o'));
// console.log(board.grid);

module.exports = Board;
