import React from "react";
import { hubFunctionRegistry } from "../Table/index.jsx";
import { SelectableMenu } from './SelectableMenu.jsx';
import './toolbar.scss'

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
            isSearchable
            placeholder="Filter by country"
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
            placeholder="Filter by function"
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
            placeholder="Sort entries by"
            handleChange={value => {
              handleOptionSelect({ name: "orderBy", value, field: true });
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



const CheckBox = ({ reference, handleChange, name }) => (
  <div className="ui checkbox">
    <input
      type="checkbox"
      name={name}
      onClick={handleChange}
    />
    <label>{reference}</label>
  </div>
);



export default ToolBar;
