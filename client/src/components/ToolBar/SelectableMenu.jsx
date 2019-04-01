import React, { useState } from "react";
import Select from "react-select";

export const SelectableMenu = props => {
  const options = props.options.map(option => ({
    value: option,
    label: option
  }));
  const [selected, setSelected] = useState(null);
  const handleChange = selectedOption => {
    setSelected(selectedOption);
    props.handleChange(selectedOption.value);
  };
  return (
    <Select
      options={[{ value: "", label: "NONE" }, ...options]}
      onChange={handleChange}
      isSearchable={props.isSearchable}
      placeholder={props.placeholder}
    />
  );
};
