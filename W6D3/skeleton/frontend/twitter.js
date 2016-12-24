const FollowToggle = require('./follow_toggle.js');
const UsersSearch = require('./users_search.js');
const TweetCompose = require('./tweet_compose.js');

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
