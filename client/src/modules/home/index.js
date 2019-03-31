import React, { Component } from "react";
import { Query } from "react-apollo";
import { cargoHubsQuery } from "./queries";
import ToolBar from "../../components/ToolBar/index.jsx";
import DisplayTable from "../../components/Table/index.jsx";

class HomePage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      options: {}
    };
  }

  handleTextChange = e => {
    e.preventDefault();
    this.setState({
      options: { ...this.state.options, [e.target.name]: e.target.value }
    });
  };

  handleOptionSelect = ({ name, value }) => {
    this.setState({ options: { ...this.state.options, [name]: value } });
  };

  renderMain = ({ data }) => {
    return (
      <div style={{ width: "60%", margin: "0 auto" }}>
        <h1 style={{ textAlign: "center" }}> Cargo hub</h1>
        <DisplayTable data={data.hubs.edges} />
        <ToolBar
          handleTextChange={this.handleTextChange}
          countries={data.countries.edges.map(({ node }) => node)}
        />
      </div>
    );
  };

  prepareOptions = () => {
    const __options = { ...this.state.options };
    if (Object.keys(__options).length) return __options;
    Object.keys(__options).forEach(
      key => !!!__options[key] && delete __options[key]
    );
    return __options;
  };

  render() {
    return (
      <Query query={cargoHubsQuery} variables={this.state.options}>
        {({ loading, error, data, refetch }) => {
          if (loading) return <div>...Loading</div>;
          if (error) return <div>uh oh something went wrong</div>;
          return this.renderMain({ data });
        }}
      </Query>
    );
  }
}

export default HomePage;
