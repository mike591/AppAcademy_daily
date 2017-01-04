import React from 'react';
import { uniqueId } from '../../util/util.js';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "", body: "", done: false };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.updateTitle = this.updateTitle.bind(this);
    this.updateBody = this.updateBody.bind(this);
  }

  updateTitle(e) {
    this.setState({ title: e.target.value});
  }

  updateBody(e) {
    this.setState({ body: e.target.value});
  }

  handleSubmit(e) {
    e.preventDefault();
    const newTodo = { title: this.state.title, body: this.state.body };
    newTodo['id'] = uniqueId();
    this.props.receiveTodo(newTodo);
    this.setState({ title: "", body: "" });
  }

  render() {
    return (
    <form onSubmit={this.handleSubmit}>

      <label> Title
        <input
          type="text"
          onChange={this.updateTitle}
          value={this.state.title}
          />
      </label>

      <br></br>
      <label> Body
        <input
          type="text"
          onChange={this.updateBody}
          value={this.state.body}
          />
      </label>
      <br></br>
      <button>Create!</button>
      <br></br>
    </form>
  );
  }
}

export default TodoForm;
