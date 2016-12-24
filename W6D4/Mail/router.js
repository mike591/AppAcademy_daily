class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start() {
    this.render();
    window.addEventListener("hashchange", () => {
      this.render();
    });
  }

  activeRoute() {
    let route = window.location.hash;
    return(this.routes[route.slice(1)]);
    // return route.slice(1);
  }

  render() {
    let component = this.activeRoute();

    if (typeof component === "undefined") {
      this.node.innerHTML = "";
    } else {
      this.node.innerHTML = "";
      let newElement = component.render();
      this.node.appendChild(newElement);
    }
  }
}

module.exports = Router;
