/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const HanoiGame = __webpack_require__(1);
	const HanoiView = __webpack_require__(3);

	$( () => {
	  const rootEl = $('.hanoi');
	  const game = new HanoiGame();
	  new HanoiView(game, rootEl);
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	class Game {
	  constructor() {
	    this.towers = [[3, 2, 1], [], []];
	  }

	  isValidMove(startTowerIdx, endTowerIdx) {
	      const startTower = this.towers[startTowerIdx];
	      const endTower = this.towers[endTowerIdx];

	      if (startTower.length === 0) {
	        return false;
	      } else if (endTower.length == 0) {
	        return true;
	      } else {
	        const topStartDisc = startTower[startTower.length - 1];
	        const topEndDisc = endTower[endTower.length - 1];
	        return topStartDisc < topEndDisc;
	      }
	  }

	  isWon() {
	      // move all the discs to the last or second tower
	      return (this.towers[2].length == 3) || (this.towers[1].length == 3);
	  }

	  move(startTowerIdx, endTowerIdx) {
	      if (this.isValidMove(startTowerIdx, endTowerIdx)) {
	        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
	        return true;
	      } else {
	        return false;
	      }
	  }

	  print() {
	      console.log(JSON.stringify(this.towers));
	  }

	  promptMove(reader, callback) {
	      this.print();
	      reader.question("Enter a starting tower: ", start => {
	        const startTowerIdx = parseInt(start);
	        reader.question("Enter an ending tower: ", end => {
	          const endTowerIdx = parseInt(end);
	          callback(startTowerIdx, endTowerIdx)
	        });
	      });
	  }

	  run(reader, gameCompletionCallback) {
	      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {
	        if (!this.move(startTowerIdx, endTowerIdx)) {
	          console.log("Invalid move!");
	        }

	        if (!this.isWon()) {
	          // Continue to play!
	          this.run(reader, gameCompletionCallback);
	        } else {
	          this.print();
	          console.log("You win!");
	          gameCompletionCallback();
	        }
	      });
	  }
	}

	module.exports = Game;


/***/ },
/* 2 */,
/* 3 */
/***/ function(module, exports) {

	class View {
	  constructor(game, $el) {
	    this.$el = $el;
	    this.game = game;
	    this.selected = [];

	    this.setupTowers();
	    this.render();
	    this.bindEvent();

	    // let $col = $(".00");
	    // $col.css("background-color", "yellow");

	    // console.log($towers.find("00"));
	    // console.log(this.game.towers);
	  }

	  setupTowers() {
	    for (let i = 0; i < 3; i++) {
	      let $row = $("<ul></ul>");
	      for (var j = 2; j >= 0; j--) {
	        let $col = $("<li></li>");
	        $col.addClass(`${i}${j}`);
	        $row.append($col);
	      }
	      $row.attr('pos', i);
	      this.$el.append($row);
	    }
	  }

	  bindEvent() {
	    let $tower = $('ul');
	    $tower.on('click', (e) => {
	      let $target = $(e.currentTarget);
	      let pos = $target.attr("pos");
	      this.selected.push(pos);

	      if (this.selected.length === 2) {
	        this.game.move(this.selected[0], this.selected[1]);
	        this.selected = [];
	      }
	      this.render();

	      if (this.game.isWon()) {
	        alert("God, you!");
	      }

	    });
	  }

	  render() {
	    let grid = this.game.towers;
	    let $towers = $("ul");
	    for (let i = 0; i < 3; i++) {
	      for (let j = 0; j < 3; j++) {
	        let $col = $(`.${i}${j}`);
	        $col.removeClass("one");
	        $col.removeClass("two");
	        $col.removeClass("three");
	        if (grid[i][j] === 3) {
	          $col.addClass("three");
	        } else if (grid[i][j] === 2) {
	          $col.addClass("two");
	        } else if (grid[i][j] === 1) {
	          $col.addClass("one");
	        }
	      }
	    }
	  }

	}

	module.exports = View;


/***/ }
/******/ ]);