class View {
  constructor(game, $el) {
    this.$el = $el;
    this.game = game;

    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    let $square = $(".square");
    $square.on("click", e => {
      const $sq = $(e.currentTarget);
      this.makeMove($sq);
    });
  }

  makeMove($square) {
    let row = $square.attr("pos")[0];
    let col = $square.attr("pos")[2];
    row = parseInt(row);
    col = parseInt(col);
    let pos = [row, col];
    // console.log(this.game.currentPlayer);
    // console.log(pos);
    if (this.game.board.isEmptyPos(pos)) {
      $square.text(`${this.game.currentPlayer}`);
      $square.addClass(`${this.game.currentPlayer}`);
      this.game.playMove(pos);
    } else {
      alert("Invalid Move Yo");
    }

    setTimeout(() => {
      if (this.game.winner() !== null) {
        alert(`CONGRATS ${this.game.winner()}`);
      }
    }, 2000);
  }

  setupBoard() {
    for (let j=0; j < 3; j++) {
      const $row = $("<ul></ul>");
      $row.addClass(`row${j}`);
      for (let i = 0; i < 3; i++) {
        const $square = $("<li></li>");
        $square.addClass(`col${i}`);
        $square.addClass("square");
        $square.attr("pos", [j, i]);
        $row.append($square);
      }
      this.$el.append($row);
    }
  }
}



module.exports = View;
