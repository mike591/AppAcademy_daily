import { connect } from 'react-redux';
import { requestCreatePokemon } from '../actions/pokemon_actions';
import PokemonForm from './pokemon_form';

const mapStateToProps = (state) => ({
  errors: state.errors
});

const mapDispatchToProps = (dispatch) => ({
  createPokemon: (pokemon) => dispatch(requestCreatePokemon(pokemon))
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonForm);
