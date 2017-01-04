import React from 'react';

class PokemonIndex extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    const pokemonList = this.props.pokemon.map((poke, idx) => (
      <li key={idx}>
        {poke.name}
        <img src={poke.image_url}/>
      </li>
    ));

    return (
      <div>
        <ul>
          {pokemonList}
        </ul>
      </div>
    );
  }
}

export default PokemonIndex;
