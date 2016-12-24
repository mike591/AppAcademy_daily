/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const FollowToggle = __webpack_require__(1);
	const UsersSearch = __webpack_require__(3);
	const TweetCompose = __webpack_require__(5);
	
	$(() => {
	  $('button.follow-toggle').each((idx, button) => {
	    new FollowToggle(button, {});
	  });
	
	  $('nav.users-search').each((idx, nav) => {
	    new UsersSearch(nav);
	  });
	
	  $('form.tweet-compose').each((idx, el) => {
	    new TweetCompose(el);
	  });
	});


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
	class FollowToggle {
	  constructor(el, options) {
	      this.$el = $(el);
	      this.userId = this.$el.data("user-id") || options.userId;
	      this.followState = (this.$el.data("initial-follow-state") ||
	                         options.followState);
	      this.render();
	
	      this.$el.on("click", this.handleClick.bind(this));
	  }
	
	    render() {
	      switch(this.followState){
	        case "followed":
	          this.$el.prop("disabled", false);
	          this.$el.html("Unfollow!");
	          break;
	        case "unfollowed":
	          this.$el.prop("disabled", false);
	          this.$el.html("Follow!");
	          break;
	        case "following":
	          this.$el.prop("disabled", true);
	          this.$el.html("Following...");
	          break;
	        case "unfollowing":
	          this.$el.prop("disabled", true);
	          this.$el.html("Unfollowing...");
	          break;
	      }
	    }
	
	    handleClick(event) {
	      const followToggle = this;
	
	      event.preventDefault();
	
	      if (this.followState === "followed") {
	        this.followState = "unfollowing";
	        this.render();
	        APIUtil.unfollowUser(this.userId).then(() => {
	          followToggle.followState = "unfollowed";
	          followToggle.render();
	        });
	      } else if (this.followState === "unfollowed") {
	        this.followState = "following";
	        this.render();
	        APIUtil.followUser(this.userId).then(() => {
	          followToggle.followState = "followed";
	          followToggle.render();
	        });
	      }
	    }
	}
	module.exports = FollowToggle;


/***/ },
/* 2 */
/***/ function(module, exports) {

	const APIUtil = {
	
	  followUser: id => APIUtil.changeFollowStatus(id, "POST"),
	
	  unfollowUser: id => APIUtil.changeFollowStatus(id, "DELETE"),
	
	  changeFollowStatus: (id, method) => (
	    $.ajax({
	      url: `/users/${id}/follow`,
	      dataType: "json",
	      method
	    })
	  ),
	
	  searchUsers: query => (
	    $.ajax({
	      url: '/users/search',
	      dataType: 'JSON',
	      method: 'GET',
	      data: { query }
	    })
	  ),
	
	  createTweet: data => (
	    $.ajax({
	      url: '/tweets',
	      dataType: 'JSON',
	      method: 'POST',
	      data: { data }
	    })
	  )
	};
	
	module.exports = APIUtil;


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	const FollowToggle = __webpack_require__(1);
	
	class UsersSearch {
	  constructor(el){
	    this.$el = $(el);
	    this.$input = this.$el.find("input[name=username]");
	    this.$ul = this.$el.find(".users");
	    this.$input.on("input", this.handleInput.bind(this));
	  }
	
	  handleInput(event){
	    if (this.$input.val() === "") {
	     this.renderResults([]);
	     return;
	   }
	
	    APIUtil.searchUsers(this.$input.val())
	      .then(users => this.renderResults(users));
	  }
	
	  renderResults(users){
	    this.$ul.empty();
	    for (let i = 0; i < users.length; i++) {
	      let user = users[i];
	
	      let $a = $("<a></a>");
	      $a.text(user.username);
	      $a.attr("href", `/users/${user.id}`);
	
	      let $followToggle = $("<button></button>");
	      new FollowToggle($followToggle, {
	        userId: user.id,
	        followState: user.followed ? "followed" : "unfollowed"
	      });
	
	      let $li = $("<li></li>");
	      $li.append($a);
	      $li.append($followToggle);
	
	      this.$ul.append($li);
	    }
	  }
	}
	
	module.exports = UsersSearch;


/***/ },
/* 4 */,
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	const APIUtil = __webpack_require__(2);
	
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


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map