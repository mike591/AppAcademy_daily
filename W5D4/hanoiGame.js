class HanoiGame {

  constructor(reader, completionCallBack) {
    this.stacks = [[1,2,3],[],[]];
    this.reader = reader;
    this.completionCallBack = completionCallBack;
  }

  promptMove(callback) {
    this.print();
    this.reader.question("Select where you want to move from: ", (startTowerIdx) => {
      this.reader.question("Select where you want to move to: ", (endTowerIdx) => {
        callback(parseInt(startTowerIdx), parseInt(endTowerIdx));
      });
    });

  }

  move(startTowerIdx, endTowerIdx) {
    if (!this.isValidMove(startTowerIdx, endTowerIdx)) {
      return false;
    }
    this.stacks[endTowerIdx].unshift(this.stacks[startTowerIdx].shift());
    return true;
  }

  print() {
    console.log(JSON.stringify(this.stacks));
  }

  isValidMove(startTowerIdx, endTowerIdx) {

    if (isNaN(startTowerIdx) || isNaN(endTowerIdx)) {
      return false;
    } else if (startTowerIdx < 0 || startTowerIdx > 2 ||
               endTowerIdx < 0 || endTowerIdx > 2 ) {
      return false;
    } else if (this.stacks[startTowerIdx].length === 0) {
      return false;
    } else if (this.stacks[endTowerIdx].length === 0) {
      return true;
    } else if (this.stacks[startTowerIdx][0] > this.stacks[endTowerIdx][0] ) {
      return false;
    } else {
      return true;
    }
  }

  isWon() {
    return this.stacks[1].length === 3 || this.stacks[2].length === 3;
  }

  run() {
    // until game is over
    // get move form player
    // produce move

    if (this.isWon()) {
      this.completionCallBack();
    } else {
      this.promptMove((startTowerIdx, endTowerIdx) => {
        if (!this.move(startTowerIdx, endTowerIdx)) {
          console.error('Invalid move');
        }
        this.run();
      });
    }
  }

}
module.exports = HanoiGame;

// let game = new HanoiGame();
//
// game.run(() => console.log('yeaaaay!'));


// IS WON TESTS
// console.log(game.isWon()); //false
// game.stacks = [[],[1,2,3],[]];
// console.log(game.isWon()); //true
// game.stacks = [[],[],[1,2,3]];
// console.log(game.isWon()); //true
// game.stacks = [[1],[2],[3]];
// console.log(game.isWon()); //false



// game.print(); // [[1,2,3],[],[]]

// MOVE TESTS
// console.log(game.move(0,1)); //true
// console.log(game.move(0,2)); //true
// console.log(game.move(2,1)); //false
// console.log(game.move(2,0)); //true
// console.log(game.stacks); // [[2,3], [1], []]
//

// is valid mode tests
// console.log(game.isValidMove(0, 1)); //true
// console.log(game.isValidMove(1, 0)); //false
// console.log(game.isValidMove(0, 4)); //false
// console.log(game.isValidMove(4, 1)); //false
// game.stacks = [[2,3],[1],[]];
// console.log(game.isValidMove(0, 1)); //false
// console.log(game.isValidMove(1, 0)); //true


// game.promptMove(function(a, b) {
//   console.log(a, b);
// });
