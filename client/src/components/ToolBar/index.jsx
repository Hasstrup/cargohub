import React, { Fragment } from "react";
import { hubFunctionRegistry } from "../Table/index.jsx";

const ToolBar = props => {
  const { handleTextChange, countries, handleOptionSelect } = props;
  return (
    <div>
      <form
        className="ui form"
        style={{
          display: "flex",
          justifyContent: "space-around"
        }}
      >
        <div className="field">
          <input
            className="ui input"
            placeholder="Search for a hub"
            type="text"
            name="searchText"
            onChange={handleTextChange}
          />
        </div>
        <div className="field">
          <SelectableMenu
            title="Filter by country"
            subtitle="Filter by country"
            options={countries.map(country => country.name)}
          />
        </div>
        <div className="field">
          <SelectableMenu
            title="Filter by function"
            subtitle="Filter by function"
            handleChange={value => {
              const [key] = Object.entries(hubFunctionRegistry).filter(node =>
                node.includes(value)
              );
              handleOptionSelect({ name: "function", value: key });
            }}
            options={Object.values(hubFunctionRegistry)}
          />
        </div>
        <div className="field">
          <SelectableMenu
            title="Sort entries by"
            subtitle="Sort entries by"
            handleChange={value => {
              handleOptionSelect({ name: "orderBy", value });
            }}
            options={["Country", "Name"]}
          />
        </div>
      </form>
    </div>
  );
};

const SelectableMenu = props => (
  <div className="ui selection simple dropdown">
    <input type="hidden" name={props.title} />
    <i className="dropdown icon" />
    <div className="default text">{props.subtitle}</div>
    <div className="menu" style={{ zIndex: 2, position: "relative" }}>
      {props.options.map(option => (
        <div
          key={option}
          style={{ backgroundColor: "white", zIndex: 10, position: "relative" }}
          className="item"
          data-value={option}
          onClick={() => props.handleChange(option)}
        >
          {option}
        </div>
      ))}
    </div>
  </div>
);

$(".ui.dropdown").dropdown();

export default ToolBar;
