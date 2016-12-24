let MessageStore = require('./message_store.js');

let Sent = {

  render: function() {
    let allMessages = MessageStore.getSentMessages();
    let container = document.createElement('ul');
    container.className += "messages";

    allMessages.forEach((message) => {
      let messageDomNode = this.renderMessage(message);
      container.appendChild(messageDomNode);
    });

    return container;
  },

  renderMessage: function(message) {
    let li = document.createElement('li');
    li.className += "message";
    li.innerHTML = `<span class='from'>${message.to}</span>
                    <span class='body'>${message.body}</span>
                    <span class='subject'>${message.subject}</span>`;

    return li;
  },

};

module.exports = Sent;
