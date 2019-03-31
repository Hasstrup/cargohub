import React, { Component } from "react";
import { ToolBarContainer } from "../../components/ToolBar/ToolBarContainer.jsx";
import { DisplayTableContainer } from "../../components/Table/TableContainer.jsx";

class HomePage extends Component {
  constructor(props) {
    super(props);
    this.state = {
      query: {}
    };
  }

  handleTextChange = e => {
    e.preventDefault();
    const newState = { ...this.state, [e.target.name]: e.target.value };
    this.setState(this.__cleanUp(newState));
  };

  handleQueryChange = ({ name, value, field }) => {
    if (field) return this.handleOrderParamsChange({ value });
    const newState = {
      ...this.state,
      query: { ...this.state.query, [name]: value }
    };
    this.setState(this.__cleanUp(newState));
  };

  handleOrderParamsChange = ({ value }) => {
    if (!value.length) {
      this.setState(this.__cleanUp({ ...this.state, orderBy: false }));
    } else {
      const __value = value.split(" ");
      const newState = {
        ...this.state,
        orderBy: { field: __value[0].toUpperCase(), direction: __value[1] }
      };
      this.setState(this.__cleanUp(newState));
    }
  };

  __cleanUpQuery = state => {
    if (state.query.nearQuery) {
      state.query.address = state.searchText;
      delete state["searchText"];
    } else {
      delete state.query.address;
    }
    delete state.query["nearQuery"];
    return state;
  };

  __cleanUp = newState => {
    const state = this.__cleanUpQuery(newState);
    state.query = this.prepareQuery(state.query);
    Object.keys(state).forEach(key => !!!state[key] && delete state[key]);
    console.log(state);
    return state;
  };

  prepareQuery = query => {
    if (!Object.keys(query).length) return query;
    Object.keys(query).forEach(key => !!!query[key] && delete query[key]);
    return query;
  };

  render() {
    return (
      <div style={{ width: "60%", margin: "0 auto" }}>
        <h1 style={{ textAlign: "center" }}> Cargo hub</h1>
        <ToolBarContainer
          handleTextChange={this.handleTextChange}
          handleOptionSelect={this.handleQueryChange}
          nearQuery={this.state.query.nearQuery}
        />
        <DisplayTableContainer variables={this.state} />
      </div>
    );
  }
}

export default HomePage;
