import {ERROR} from '../actions/pokemon_actions';

const ErrorsReducer = (state = [], action) => {
  switch (action.type) {
    case ERROR:
      return action.error;
    default:
      return state;
  }
};

export default ErrorsReducer;
