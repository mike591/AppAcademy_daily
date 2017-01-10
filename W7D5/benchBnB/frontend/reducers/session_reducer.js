import {RECEIVE_CURRENT_USER, RECEIVE_ERRORS} from '../actions/session_actions';
import merge from 'lodash/merge';

const _defaultState = {
  currentUser: null,
  errors: []
};

const sessionReducer = (state = _defaultState, action) => {
  Object.freeze(state);
  let newState;
  switch (action.type) {
    case RECEIVE_CURRENT_USER:
      newState = merge({}, _defaultState, {currentUser: action.currentUser});
      return newState;
    case RECEIVE_ERRORS:
      newState = merge({}, _defaultState, {errors: action.errors.responseJSON});
      return newState;
    default:
      return state;
  }
};

export default sessionReducer;
