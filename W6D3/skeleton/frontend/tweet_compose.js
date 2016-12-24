const APIUtil = require("./api_util.js");

class TweetCompose {
  constructor(el){
    this.$el = $(el);

    this.$el.on('submit', this.submit.bind(this));
  }

  submit(event){
    let data = $(event.currentTarget).serialize();
    APIUtil.createTweet(data);
    this.$el.find("input[type=Submit]").prop("disabled", true);
  }

  clearInput() {
    this.$el.input.val = "";
  }

  handleSuccess() {
    let stuff = this.$el.input.val;
    this.clearInput();
    this.$el.find("input[type=Submit]").prop("disabled", false);
  }
}

module.exports = TweetCompose;
