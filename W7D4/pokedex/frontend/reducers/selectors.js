import { values } from 'lodash';

export const selectAllPokemon = (state) => {
  return (values(state.pokemon));
};

export const selectPokemonItem = (state, itemId) => {
  let returnItem = {};
  state.pokemonDetail.items.forEach((item) => {
    if (item.id === parseInt(itemId)) {
      returnItem = item;
    }
  });

  return returnItem;
};
