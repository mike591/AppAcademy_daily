import React from 'react';
import { Link } from 'react-router';

class Greeting extends React.Component {
  constructor(props) {
    super(props)

    this.logout = this.logout.bind(this);
  }

  logout(e) {
    e.preventDefault();
    this.props.logout();
  }

  render() {

    if (this.props.currentUser) {
      return(
        <div>
          <h1>
            WELCOME, {this.props.currentUser.username}
          </h1>
          <button onClick={this.logout}>Log Out</button>
        </div>
      )
    } else {
      return(
        <div>
          <Link to='/signup'>Sign Up!</Link>
          <br></br>
          <Link to='/login'>Log In!</Link>
        </div>
      )
    }
  }
}

export default Greeting;
