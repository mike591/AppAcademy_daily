

export const allTodos = (state) => {
  const keys = Object.keys(state.todos);
  const todos = keys.map( key => state.todos[key]);
  return todos;
};
