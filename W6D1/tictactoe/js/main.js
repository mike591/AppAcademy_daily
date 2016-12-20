const View = require("./ttt-view.js"); // require appropriate file
const Game = require("./game.js"); // require appropriate file

$( () => {
  // Your code here
  let $figure = $(".ttt");

  let game = new Game();
  new View(game, $figure);
});
