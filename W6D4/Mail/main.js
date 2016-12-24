let Router = require("./router.js");
let Inbox = require("./Inbox.js");
let Sent = require("./sent.js");

let routes = {
  inbox: Inbox,
  sent: Sent,
};

document.addEventListener("DOMContentLoaded", function(event) {
  let content = document.querySelector(".content");
  let router = new Router(content, routes);
  router.start();

  let sidebarLi = this.querySelectorAll('.sidebar-nav li');

  sidebarLi.forEach((el) => {
    el.addEventListener("click", () => {
      let name = el.innerText.toLowerCase();
      window.location.hash = name;
    });
  });

});
