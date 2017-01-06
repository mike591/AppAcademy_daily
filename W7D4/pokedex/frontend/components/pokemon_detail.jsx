import React from 'react';

class PokemonDetail extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.requestSinglePokemon(this.props.params.pokemonId);
  }

  componentWillReceiveProps(newProps) {
    if (newProps.params.pokemonId != this.props.params.pokemonId) {
      this.props.requestSinglePokemon(newProps.params.pokemonId);
    }
  }

  render() {
    const items = this.props.pokemon.items.map((item) => (
      <li key={item.id}>
        <img
          className="itemImage"
          src={item.image_url}
          onClick={ () => {
            this.props.router.push(`pokemon/${this.props.pokemon.id}/item/${item.id}`);
          }
        }></img>
      </li>
    ));

    return(
      <div>
        <img src={this.props.pokemon.image_url}/>
        <p>{this.props.pokemon.name}</p>
        <p>Type: {this.props.pokemon.poke_type}</p>
        <p>Attack: {this.props.pokemon.attack}</p>
        <p>Defense: {this.props.pokemon.defense}</p>
        <p>Moves: {this.props.pokemon.moves}</p>
        <ul>
          {items}
        </ul>
        <div>
            {this.props.children}
        </div>
      </div>
    );
  }
}

export default PokemonDetail;
