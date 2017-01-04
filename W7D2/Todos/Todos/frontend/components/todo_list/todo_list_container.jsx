import { connect } from 'react-redux';
import TodoList from './todo_list';

// Actions
import { receiveTodos, fetchTodos, createTodo,
  updateTodo, deleteTodo  } from '../../actions/todo_actions';
import { allTodos } from '../../reducers/selectors';

const mapStateToProps = state => {
  return ({
  todos: allTodos(state),
  errors: state.errors,
  state
});
};

const mapDispatchToProps = dispatch => ({
  receiveTodos: () => dispatch(receiveTodos()),
  createTodo: (todo) => dispatch(createTodo(todo)),
  fetchTodos: () => dispatch(fetchTodos()),
  updateTodo: (todo) => dispatch(updateTodo(todo)),
  deleteTodo: (todo) => dispatch(deleteTodo(todo))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
