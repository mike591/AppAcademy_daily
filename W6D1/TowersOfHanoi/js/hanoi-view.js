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
