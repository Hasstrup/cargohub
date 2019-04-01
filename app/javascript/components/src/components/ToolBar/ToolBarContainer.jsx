import React from "react";
import { Query } from "react-apollo";
import { countriesQuery as query } from "../../modules/home/queries";
import ToolBar from "./index.jsx";

export const ToolBarContainer = props => (
  <Query query={query}>
    {({ loading, error, data }) => {
      if (loading) return <div> ...Loading</div>;
      if (error) return <div> Uh oh something went wrong</div>;
      return (
        <ToolBar
          {...props}
          countries={data.countries.edges.map(({ node }) => node)}
        />
      );
    }}
  </Query>
);
