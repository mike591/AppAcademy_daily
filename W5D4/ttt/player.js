class Player {

  constructor(name, mark) {
    this.name = name;
    this.mark = mark;
  }

  promptMove(reader, callback) {
    reader.question("Select row: ", (row) => {
      reader.question("Select col: ", (col) => {
        callback(parseInt(row), parseInt(col));
      });
    });
  }
}

module.exports = Player;
