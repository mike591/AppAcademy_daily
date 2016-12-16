class Ai {

  constructor(name, mark, board) {
    this.name = name;
    this.mark = mark;
    this.board = board;
  }

  promptMove(reader, callback) {
    let arr = this.board.emptyPos();
    let i = parseInt(Math.random() * arr.length);
    callback(arr[i]);
  }





}
