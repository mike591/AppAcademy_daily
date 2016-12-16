const Board = require('./board.js');
const Player = require('./player.js');



class TicTacToe {
  constructor(reader, completionCallBack, ...players) {
    this.reader = reader;
    this.completionCallBack = completionCallBack;
    this.players = players;
    this.board = new Board;
  }

  play() {
    // while not board.isWon()
      //get move from current player
      //try to produce move
      // if ok - next player play
      // if not - same player play again
      if (this.board.isWon()) {
        this.completionCallBack();
      } else {
        this.board.render();
        this.players[0].promptMove(this.reader, (row, col) => {
          if (this.board.placeMark([row, col], this.players[0].mark)) {
            this.players.push(this.players.shift());
          } else {
            console.error("Invalid Move");
          }
          this.play();
        });
      }

    //congrats board winner
    //call completionCallBack()
  }
}

const readline = require('readline');
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

let me = new Player("me", "x");
let you = new Player("you", "o");

let game = new TicTacToe(reader, function() {
  console.log("Yyay");
}, me, you);

game.play();


// game.board.placeMark([1,1], 'x');
// game.board.placeMark([0,0], 'x');
// game.board.placeMark([2,2], 'x');
// game.board.render();
// console.log(game.board.isWon());

module.exports = TicTacToe;
