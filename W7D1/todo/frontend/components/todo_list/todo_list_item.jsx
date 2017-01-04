import React from 'react';
import TodoDetailViewContainer from './todo_detail_view_container';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);

    this.handleDone = this.handleDone.bind(this);
  }


  handleDone(e) {
    e.preventDefault();
    this.updateTodo(this.props.todo);
    this.props.receiveTodo(this.props.todo);
  }

  updateTodo(todo) {
    todo.done = !todo.done;
  }


  render() {
    return (
      <li>
        {this.props.todo.title}
        <button onClick={this.handleDone}>{this.props.todo.done ? 'Undo' : 'Done'}</button>
        <TodoDetailViewContainer />
      </li>
    );
  }

}

export default TodoListItem;
