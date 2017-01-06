import React from 'react';
import { withRouter } from 'react-router';

const TYPES = [
    "fire",
    "electric",
    "normal",
    "ghost",
    "psychic",
    "water",
    "bug",
    "dragon",
    "grass",
    "fighting",
    "ice",
    "flying",
    "poison",
    "ground",
    "rock",
    "steel"
  ];

class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      attack: 0,
      defense: 0,
      image_url: "",
      name: "",
      poke_type: ""
    };

    this.inputHandle = this.inputHandle.bind(this);
    this.createPokemon = this.createPokemon.bind(this);
  }

  inputHandle(event) {
    let newValue = event.target.value;
    if (event.target.name === "attack" || event.target.name === "defense") {
      newValue = parseInt(newValue);
      if (isNaN(newValue)) {
        newValue = 0;
      }
    }
    this.setState({[event.target.name]: newValue});
  }

  createPokemon(event) {
    event.preventDefault();
    this.props.createPokemon(this.state)
      .then((newPokemon) => (
        this.props.router.push(`pokemon/${newPokemon.id}`)
      ));
  }

  render() {
    let typeOptions = TYPES.map((type, idx) => (
      <option value={type}
              key={idx}
              >{type}
      </option>
    ));

    let errorList = this.props.errors.map((error, idx) => (
      <li key={idx}>{error}</li>
    ));

    return (
      <div>
        <ul>
          {errorList}
        </ul>
        <form>
          Name:<input type="text"
                 onChange={this.inputHandle}
                 value={this.state.name}
                 name="name">
          </input><br></br>

        Attack:<input type="text"
                 onChange={this.inputHandle}
                 value={this.state.attack}
                 name="attack">
          </input><br></br>

        Defense:<input type="text"
                 onChange={this.inputHandle}
                 value={this.state.defense}
                 name="defense">
          </input><br></br>

        Image URL:<input type="text"
                 onChange={this.inputHandle}
                 value={this.state.image_url}
                 name="image_url">
          </input><br></br>

        Type:<select onChange={this.inputHandle}
                     name="poke_type">
          {typeOptions}
        </select><br></br>

          <button onClick={this.createPokemon}>Create Pokemon</button>
        </form>
      </div>
    );
  }

}

export default withRouter(PokemonForm);
