import React from 'react';
import { Link } from 'react-router';

class SessionForm extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      username: "",
      password: ""
    }

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleUsername = this.handleUsername.bind(this);
    this.handlePassword = this.handlePassword.bind(this);
  }

  handleSubmit(e) {
    e.preventDefault();
    const user = Object.assign({}, this.state);
    this.props.processForm(user).then(() => this.redirect());
  }

  redirect() {
    this.props.router.push('/');
  }

  handleUsername(e) {
    let username = e.target.value;
    this.setState({username: username});
  }

  handlePassword(e) {
    let password = e.target.value;
    this.setState({password: password});
  }

  render() {
    let link = (this.props.formType === 'login') ? '/signup' : '/login'
    let linkTitle = link.slice(1);
    const errors = this.props.errors.map((error, idx) => {
      return (<li key={idx}>{error}</li>)
    });

    return (
      <div>
        <h1>{this.props.formType}</h1>
        <br></br>

        Username: <input onChange={this.handleUsername} type='text'></input>
        <br></br>
        Password: <input onChange={this.handlePassword} type='text'></input>
        <br></br>
        <button onClick={this.handleSubmit}>Submit!</button>
        <br></br>
        <br></br>
        <Link to={link}>{linkTitle}</Link>
        <ul>
          {errors}
        </ul>
      </div>
    )
  }
}

export default SessionForm;
