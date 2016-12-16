const Game = require('./game.js');

const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function completionCallBack() {
  reader.question("Would you like to play again? (y/n)", (answer) => {
    if (answer === 'y') {
      let newGame = new Game(reader, completionCallBack);
      newGame.run();
    } else {
      console.log("Good bye!");
      reader.close();
    }
  });
}

let game = new Game(reader, completionCallBack);
game.run();
