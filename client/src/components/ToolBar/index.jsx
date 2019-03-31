import React, { Fragment } from "react";

const ToolBar = () => {
  return (
    <div>
      <form className="ui form">
        <div className="field">
          <label>Search for a hub</label>
          <input className="ui input" type="text" />
        </div>
        <div className="field">
          <SelectableMenu
            title="Filter by country"
            subtitle="Filter by country"
            options={[ "Andorra"]}
          />
        </div>
        <div className="field">
          <SelectableMenu
            title="Filter by function"
            subtitle="Filter by function"
            options={[ "Andorra"]}
          />
        </div>
        <div className="field">
          <SelectableMenu
            title="Sort entries by"
            subtitle="Sort entries by"
            options={[ "Country", "Name"]}
          />
        </div>
      </form>
    </div>
  );
};

const SelectableMenu = props => (
  <div className="ui selection dropdown">
    <input type="hidden" name={props.title} />
    <i className="dropdown icon" />
    <div className="default text">{props.subtitle}</div>
    <div className="menu">
      {props.options.map(option => (
        <div key={option} className="item" data-value={option}>
          {option}
        </div>
      ))}
    </div>
  </div>
);

export default ToolBar;
