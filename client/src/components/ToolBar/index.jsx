import React from "react";
import { hubFunctionRegistry } from "../Table/index.jsx";

const ToolBar = props => {
  const { handleTextChange, countries, handleOptionSelect, nearQuery } = props;
  return (
    <div>
      <form
        className="ui form"
        style={{
          display: "flex",
          flexDirection: "row",
          flexWrap: "wrap",
          
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
            handleChange={value => {
              const { symbol } = countries.find(
                country => country.name === value
              );
              handleOptionSelect({ name: "country", value: symbol });
            }}
          />
        </div>
        <div className="field">
          <SelectableMenu
            title="Filter by function"
            subtitle="Filter by function"
            handleChange={value => {
              const [key] = Object.entries(hubFunctionRegistry).find(node =>
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
              handleOptionSelect({ name: "orderBy", value, order: true });
            }}
            options={["Country ASC", "Name ASC", "Country DESC", "Name DESC"]}
          />
        </div>
        <div className="field">
          <CheckBox
            reference="Hubs near you?"
            selected={nearQuery}
            name="nearQuery"
            handleChange={() => {
              handleOptionSelect({ name: "nearQuery", value: !nearQuery });
            }}
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
      {props.options.map((option, index) => (
        <div
          key={`${index}-${option}`}
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

const CheckBox = ({ reference, selected, handleChange, name }) => (
  <div className="ui checkbox">
    <input
      type="checkbox"
      name={name}
      onChange={handleChange}
      {...(selected ? { checked: "true" } : {})}
    />
    <label>{reference}</label>
  </div>
);

$(".ui.dropdown").dropdown();

export default ToolBar;
