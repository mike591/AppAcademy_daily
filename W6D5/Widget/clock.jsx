import React from "react";

class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }

  componentDidMount() {
    window.setInterval(() => {
      this.incrementTime();
    }, 1000);
  }

  incrementTime() {
    const currentDate = this.state.date;
    const newDate = currentDate.setSeconds(currentDate.getSeconds() + 1);
    debugger;
    this.setState({date: newDate});
  }

  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}.</h2>
      </div>
    );
  }
}

export default Clock;
