import React from 'react';
import { Link } from 'react-router';

const PokemonIndexItem = ({pokemon}) => {
  return (
    <li>
      <Link to={`/pokemon/${pokemon.id}`}>
        <h3>{pokemon.name}</h3>
        <img src={pokemon.image_url}></img>
      </Link>
    </li>
  );
};

export default PokemonIndexItem;
