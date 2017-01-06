import * as APIUtil from '../util/api_utils';

export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_POKEMON = "RECEIVE_POKEMON";
export const RECEIVE_NEW_POKEMON = "RECEIVE_NEW_POKEMON";
export const ERROR = "ERROR";

export const receiveAllPokemon = (pokemon) => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon: pokemon
});

export const receivePokemon = (pokemon) => ({
  type: RECEIVE_POKEMON,
  pokemonDetail: pokemon
});

export const receiveNewPokemon = (pokemon) => ({
  type: RECEIVE_NEW_POKEMON,
  pokemon: pokemon
});

export const receivePokemonErrors = (error) => ({
  type: ERROR,
  error: error.responseJSON
});

export const requestAllPokemon = () => (dispatch) => {
  return APIUtil.fetchAllPokemon()
    .then(pokemon => dispatch(receiveAllPokemon(pokemon)));
};

export const requestSinglePokemon = (id) => (dispatch) => {
  return APIUtil.fetchPokemon(id)
    .then(pokemon => dispatch(receivePokemon(pokemon)));
};

export const requestCreatePokemon = (pokemon) => (dispatch) => {
  return APIUtil.createPokemon(pokemon)
    .then(res => {
      dispatch(receiveNewPokemon(res));
      return res;
    }, err => {dispatch(receivePokemonErrors(err));
    });
};
