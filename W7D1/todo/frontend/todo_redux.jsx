import React from "react";
import ReactDOM from "react-dom";

import store from './store/store.js';
import { allTodos } from './reducers/selectors';

import { receiveTodo, receiveTodos } from './actions/todo_actions';
import Root from './components/root.jsx';

window.store = store;
window.allTodos = allTodos;
window.receiveTodo = receiveTodo;
window.receiveTodos = receiveTodos;

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("root");
  ReactDOM.render(<Root store={store} />, root);
});
