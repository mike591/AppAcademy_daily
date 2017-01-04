import React from 'react';
import { connect } from 'react-redux';
import { removeTodo, receiveTodo } from '../../actions/todo_actions';
import TodoDetailView from './todo_detail_view';

const mapDispatchToProps = (dispatch) => ({
  removeTodo: (todo) => dispatch(removeTodo(todo)),
  receiveTodo: (todo) => dispatch(receiveTodo(todo))
});

export default connect(null, mapDispatchToProps)(TodoDetailView);
