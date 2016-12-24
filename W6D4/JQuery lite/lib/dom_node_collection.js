class DOMNodeCollection {
  constructor(nodes) {
    this.nodes = nodes;
  }

  each(cb) {
    this.nodes.forEach(cb);
  }

  html(string) {
    if (typeof string === "string") {
      // this.each(node => node.innerHTML = html);
      this.each((node) => node.innerHTML = html);
    } else {
      // return this.nodes[0].innerHTML;
      return this.nodes[0].innerHTML;
    }
  }

  empty() {
    this.html = "";
  }

  append(children) {
    if (this.nodes.length === 0) {
      return;
    }

    if (typeof children === 'object' && !(children instanceof DomNodeCollection)) {
      // ensure argument is coerced into DomNodeCollection
      children = $l(children);
    }

    if (typeof children === "string") {
      this.each(node => node.innerHTML += children);
    } else if (children instanceof DomNodeCollection) {
      // You can't append the same child node to multiple parents,
      // so we must duplicate the child nodes here.
      this.each(node => {
        // The argument to cloneNode indicates whether or not
        // all children should be cloned.
        children.each(childNode => {
          node.appendChild(childNode.cloneNode(true));
        });
      });
    }
  }

  attr(key, val) {
     if (typeof val === "string") {
       this.each( node => node.setAttribute(key, val) );
     } else {
       return this.nodes[0].getAttribute(key);
     }
   }

   addClass(newClass) {
     this.each(node => node.classList.add(newClass));
   }

   removeClass(oldClass) {
     this.each(node => node.classList.remove(oldClass));
   }

   children() {
     let childNodes = [];
     this.each(node => {
       const childNodeList = node.children;
       childNodes = childNodes.concat(Array.from(childNodeList));
     });
     return new DomNodeCollection(childNodes);
   }

   parent() {
     const parentNodes = [];
     this.each(node => parentNodes.push(node.parentNode));
     return new DomNodeCollection(parentNodes);
   }

   find(selector) {
     let foundNodes = [];
     this.each(node => {
       const nodeList = node.querySelectorAll(selector);
       foundNodes = foundNodes.concat(Array.from(nodeList));
     });
     return new DomNodeCollection(foundNodes);
   }

   remove() {
     this.each(node => node.parentNode.removeChild(node));
   }

   on(eventName, callback) {
     this.each(node => {
       node.addEventListener(eventName, callback);
       const eventKey = `jqliteEvents-${eventName}`;
       if (typeof node[eventKey] === "undefined") {
         node[eventKey] = [];
       }
       node[eventKey].push(callback);
     });
   }

   off(eventName) {
     this.each(node => {
       const eventKey = `jqliteEvents-${eventName}`;
       if (node[eventKey]) {
         node[eventKey].forEach(callback => {
           node.removeEventListener(eventName, callback);
         });
       }
       node[eventKey] = [];
     });
   }
}
module.exports = DOMNodeCollection;
