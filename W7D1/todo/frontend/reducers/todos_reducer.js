import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO} from "../actions/todo_actions";
import merge from 'lodash/merge';

const initialState = {
  1: {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  },
};

const todosReducer = (state = initialState, action) => {
  Object.freeze(state);
  switch(action.type) {
    case RECEIVE_TODOS:
      const newState = {};
      for(let i = 0; i < action.todos.length; i++) {
        newState[i+1] = action.todos[i];
      }
      return newState;
    case RECEIVE_TODO:
      // debugger
      const id = action.todo.id;
      let result = merge({}, state);
      result[id] = action.todo;
      return result;
    case REMOVE_TODO:
      let removeState = merge({}, state);
      delete removeState[action.todo.id];
      return removeState;
    default:
      return state;
  }
};



export default todosReducer;
