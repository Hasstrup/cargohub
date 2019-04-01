import React from "react";
import { Query } from "react-apollo";
import { cargoHubsQuery } from "../../modules/home/queries";
import DisplayTable from "./index.jsx";

export const DisplayTableContainer = props => {
  return (
    <Query query={cargoHubsQuery} variables={props.variables}>
      {({ loading, error, data }) => {
        if (loading) return <div>Loading</div>;
        if (error) return <div> Looks like something went wrong</div>;
        return <DisplayTable {...props} data={data.hubs.edges} />;
      }}
    </Query>
  );
};
