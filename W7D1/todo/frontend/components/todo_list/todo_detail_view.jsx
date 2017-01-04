import React from 'react';
import TodoForm from './todo_form';

class TodoDetailView extends React.Component {
  constructor(props){
    super(props);

    this.handleDelete = this.handleDelete.bind(this);
  }

  handleDelete(e) {
      e.preventDefault();
      this.props.removeTodo(this.props.todo);
  }

  render() {
    return(
      <div className="hidden">
        <TodoForm receiveTodo={this.props.receiveTodo}/>
        <button onClick={this.handleDelete}>Delete Todo</button>
      </div>
    );
  }
}

export default TodoDetailView;
