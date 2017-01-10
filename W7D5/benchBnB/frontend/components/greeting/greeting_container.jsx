import { connect } from 'react-redux';
import Greeting from './greeting';
import {signup, login, logout} from '../../actions/session_actions';

const mapStateToProps = (state) => ({
 currentUser: state.session.currentUser
});

const mapDispatchToProps = (dispatch) => ({
  signup: () => dispatch(signup()),
  login: () =>  dispatch(login()),
  logout: () =>  dispatch(logout())
});

export default connect(mapStateToProps, mapDispatchToProps)(Greeting)
