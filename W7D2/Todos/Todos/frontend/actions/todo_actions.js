import * as TodoUtilApi from '../utils/todo_api_util';
import { receiveErrors } from './error_actions';

export const RECEIVE_TODOS = "RECEIVE_TODOS";
export const RECEIVE_TODO = "RECEIVE_TODO";
export const REMOVE_TODO = "REMOVE_TODO";

export const receiveTodos = todos => ({
  type: RECEIVE_TODOS,
  todos
});

export const receiveTodo = todo => ({
  type: RECEIVE_TODO,
  todo
});

export const removeTodo = todo => ({
  type: REMOVE_TODO,
  todo
});

export const fetchTodos = () => (dispatch) => (
  TodoUtilApi.requestTodos().then(res => dispatch(receiveTodos(res)))
);

export const createTodo = (todo) => (dispatch) => (
  TodoUtilApi.postTodo(todo)
    .then(res => dispatch(receiveTodo(res)),
          err => dispatch(receiveErrors(err.responseJSON)))
);

export const updateTodo = (todo) => (dispatch) => (
  TodoUtilApi.updateTodo(todo)
    .then(res => dispatch(receiveTodo(res)),
          err => dispatch(receiveErrors(err.responseJSON)))
);

export const deleteTodo = (todo) => (dispatch) => (
  TodoUtilApi.deleteTodo(todo)
    .then(res => dispatch(removeTodo(res)),
          err => dispatch(receiveErrors(err.responseJSON)))
);

// export const todoError = error => ({
//   type: TODO_ERROR,
//   error
// })
