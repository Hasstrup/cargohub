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

  renderMain = ({ data }) => {
    console.log(data)
    return (
      <div>
        <h3> Cargo efxwhub</h3>
        <ToolBar />
        <DisplayTable />
      </div>
    );
  };

  prepareOptions = () => {
    const __options = { ...this.state.options };
    if (Object.keys(__options).length) return __options;
    Object.keys(__options).forEach(
      key => !!!__options[key] && delete __options[key]
    );
    return __options
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
