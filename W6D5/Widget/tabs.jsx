import React from "react";
import Clock from "./clock";

class Tabs extends React.Component {
  constructor(props) {
    super(props);
    this.state = {index: 0};
  }

  setContent(index) {
    this.setState({index});
  }

  render() {
    const tabs = this.props.tabs;
    const listItems = tabs.map((el, index) => (
        <li className="title" key={index} onClick={this.setContent.bind(this, index)}>
          <h1>{el.title}</h1>
        </li>
    ));

    return (
      <div>
        <div className="tabs">
          <ul className="titles">
            {listItems}
          </ul>
          <section className="content">
            <article>{tabs[this.state.index]["content"]}</article>
          </section>
        </div>
        <div>
          <Clock />
        </div>
      </div>
    );
  }
}

export default Tabs;
