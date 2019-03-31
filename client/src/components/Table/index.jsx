import React, { Fragment } from "react";
import Table from "react-table";
import "react-table/react-table.css";

const hubFunctionRegistry = {
  "1": "port",
  "2": "rail",
  "3": "road",
  "4": "airport",
  "5": "postal office",
  "6": "inland clearance deposit"
};

const DisplayTable = ({ data }) => {
  const __data = () => data.map(({ node }) => node);
  const columns = [
    {
      Header: "Locode",
      accessor: "locode"
    },
    {
      Header: "Name",
      accessor: "name"
    },
    {
      Header: "Country",
      id: "sub_col_country",
      accessor: row => row.country && row.country.name
    },
    {
      Header: "Status",
      accessor: "status"
    },
    {
      Header: "coordinates",
      accessor: "coordinates"
    },
    {
      Header: "function",
      id: "sub_col_function",
      accessor: row => yieldHubFunction(row.function)
    }
  ];

  const yieldHubFunction = str => {
    if (!str) return "";
    let formattedStr = str.replace(/-/g, "").trim();
    Object.keys(hubFunctionRegistry).forEach(key => {
      if (formattedStr.includes(key)) {
        formattedStr = formattedStr.replace(
          key,
          `  ${hubFunctionRegistry[key]}`
        );
      }
    });
    return formattedStr;
  };

  return (
    <Fragment>
      {!data.length && <ErrorMessage />}
      {data.length && <Table columns={columns} data={__data()} />}
    </Fragment>
  );
};

const ErrorMessage = () => (
  <h4> Uh oh! We can't find any hubs matching that</h4>
);

export default DisplayTable;
